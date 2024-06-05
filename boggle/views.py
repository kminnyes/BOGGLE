from django.shortcuts import render
from boggle.serializer import ReportSerializer, TaskSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view
from boggle.models import Task
from boggle.models import Report
import requests
from django.http import HttpResponseNotAllowed, JsonResponse
from rest_framework import status


# 회원가입
@api_view(['POST'])
def register_user(request):
    if request.method == 'POST':
        serializer = UserlistSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

## 세제 인증하기 
@api_view(['POST'])
def addTask(request):
    if request.method == 'POST':
        serializer = TaskSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=200)
        else:
            print(serializer.errors)
    return Response(serializer.errors, status = 400)

@api_view(['GET'])
def getTaskList(request):
    TaskSetQuery = Task.objects.all()
    serializer = TaskSerializer(TaskSetQuery, many =True)
    print(serializer.data)
    return Response(serializer.data, status=200)


@api_view(['GET'])
def updateTask(request, pk, work):
    targetTask = Task.objects.all().get(id=pk)
    targetTask.work = work
    targetTask.isComplete = False
    # 이미지 데이터를 요청에서 가져와서 image 필드에 할당
    image = request.FILES.get('image')
    if image:
        targetTask.image = image
    targetTask.save()
    serialized_Task = TaskSerializer(targetTask)
    return Response(serialized_Task.data, status=200)

@api_view(['GET'])
def deleteTask(request,pk):
    Task.objects.get(id=pk).delete()
    return Response(status =200)


##퀴즈 맞추기
import os
import django
from urllib.parse import urlencode, unquote
import requests
from bs4 import BeautifulSoup

# Django 프로젝트 설정을 로드합니다.
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings")  # 여기를 프로젝트 설정 모듈에 맞게 수정하세요
django.setup()

from boggle.models import Dictionary

serviceKey = "REh3PMeCnCEQ8FDmxaJsDJdEVH8X1%2BsvbH%2B0muVQSeCsWAgkk7AMmT9CzH2o5hK5zfL1Pf2hH2uwTS5JnQcx2g%3D%3D"
serviceKeyDecoded = unquote(serviceKey, 'UTF-8')

def check_water_dictionary(searchNms=["물", "오염", "환경", "수질"], numOfRows=100):
    url = "http://apis.data.go.kr/B500001/myportal/dictionary/dictionarylist"
    results = []
    
    for searchNm in searchNms:
        print(f"Searching for: {searchNm}")
        # First request to get the total number of entries
        params = {
            'serviceKey': serviceKeyDecoded,
            'numOfRows': numOfRows,
            'pageNo': 1,
            '_type': 'xml',
            'searchNm': searchNm
        }
        
        query_string = urlencode(params)
        request_url = f"{url}?{query_string}"
        
        response = requests.get(request_url)
        print(f"Response status code for {searchNm}: {response.status_code}")
        
        if response.status_code == 200:
            xml = response.text
            soup = BeautifulSoup(xml, 'html.parser')
            
            # Check if totalcount is present
            totalCountTag = soup.find('totalcount')
            if totalCountTag is None:
                print(f"No totalcount found for {searchNm}")
                continue
            
            totalCount = int(totalCountTag.text)
            totalPages = (totalCount // numOfRows) + 1
            print(f"Total count for {searchNm}: {totalCount}, Total pages: {totalPages}")
            
            # Get data for each page
            for pageNo in range(1, totalPages + 1):
                params['pageNo'] = pageNo
                query_string = urlencode(params)
                request_url = f"{url}?{query_string}"
                
                response = requests.get(request_url)
                print(f"Response status code for {searchNm} page {pageNo}: {response.status_code}")
                
                if response.status_code == 200:
                    xml = response.text
                    soup = BeautifulSoup(xml, 'html.parser')
                    
                    items = soup.find_all('item')
                    
                    for item in items:
                        hNm = item.find('hnm').text if item.find('hnm') else None
                        explain = item.find('explain').text if item.find('explain') else None
                        
                        # explain이 null인 경우 저장하지 않음
                        if explain:
                            result = {
                                'hNm': hNm,
                                'explain': explain,
                            }
                            results.append(result)
                        else:
                            print(f"Skipping entry with null explain: {hNm}")
                else:
                    print(f"Failed to retrieve data for page: {pageNo}")
        else:
            print(f"Failed to retrieve data for search term: {searchNm}")
    
    print(f"Total results fetched: {len(results)}")
    return results

def save_to_django():
    entries = check_water_dictionary()
    saved_words = set()  # 이미 저장된 단어를 추적하기 위한 집합
    
    for entry in entries:
        if entry['hNm'] and entry['explain']:  # 데이터 검증
            # 중복된 단어인지 확인하고, 저장되지 않은 단어라면 저장
            if entry['hNm'] not in saved_words:
                saved_words.add(entry['hNm'])
                Dictionary.objects.get_or_create(hNm=entry['hNm'], defaults={'explain': entry['explain']})

if __name__ == "__main__":
    save_to_django()

from django.http import JsonResponse
from .models import Dictionary
from django.views.decorators.csrf import csrf_exempt
import json

@csrf_exempt
def check_answer(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        question = data.get('question')
        user_answer = data.get('answer')
        
        entry = Dictionary.objects.filter(explain=question).first()
        
        if entry and entry.hNm == user_answer:
            return JsonResponse({'result': 'correct'})
        else:
            return JsonResponse({'result': 'incorrect'})
    else:
        return JsonResponse({'error': 'Invalid HTTP method'}, status=400)

import random
from django.http import JsonResponse
from .models import Dictionary

def generate_quiz(num_questions=5):
    entries = list(Dictionary.objects.all().values('hNm', 'explain'))
    selected_entries = random.sample(entries, num_questions)
    
    quiz_data = []
    for entry in selected_entries:
        other_entries = [e for e in entries if e['hNm'] != entry['hNm']]
        choices = random.sample(other_entries, 3)
        choices.append(entry)
        random.shuffle(choices)
        
        quiz_item = {
            'hNm': entry['hNm'],
            'explain': entry['explain'],
            'choices': [choice['hNm'] for choice in choices]
        }
        quiz_data.append(quiz_item)
    
    return quiz_data

def quiz_data_api(request):
    quiz_data = generate_quiz(num_questions=10)  
    return JsonResponse(quiz_data, safe=False)


# 하수구 신고 하기 

from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Report
from .serializer import ReportSerializer, UserlistSerializer

@api_view(['POST'])
def addReport(request):
    if request.method == 'POST':
        serializer = ReportSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=200)
        else:
            return Response(serializer.errors, status=400)

@api_view(['GET'])
def getReportList(request):
    reports = Report.objects.all()
    serializer = ReportSerializer(reports, many=True)
    return Response(serializer.data, status=200)

@api_view(['POST'])
def updateReport(request, pk):
    report = Report.objects.get(id=pk)
    report.title = request.data.get('title',report.title)
    report.work = request.data.get('work', report.work)
    if 'image' in request.FILES:
        report.image = request.FILES['image']
    report.save()
    serializer = ReportSerializer(report)
    return Response(serializer.data, status=200)

@api_view(['DELETE'])
def deleteReport(request, pk):
    Report.objects.get(id=pk).delete()
    return Response(status=200)


