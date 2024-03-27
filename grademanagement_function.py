# 윤별 20240327 성적관리프로그램 (함수)
rows = 5    # 학생수
cols = 8    # 학번(0), 이름(1), 영어(2), c언어(3), 파이썬(4), 총점(5), 평균(6), 학점(7)
student_info = [[0 for j in range(cols)] for i in range(rows)]
score_list = [0] * rows
lenth = len(student_info)

def get_scores(idx, lenth):
    std_num = input("학번: ")
    name = input("이름: ")
    eng = input("영어 성적: ")
    c = input("C-언어 성적: ")
    python = input("파이썬 성적: ")
    print()

    student_info[idx][0] = std_num
    student_info[idx][1] = name
    student_info[idx][2] = eng
    student_info[idx][3] = c
    student_info[idx][4] = python

    return std_num, name, eng, c, python

def get_total(idx, eng, c, python):
    total = int(eng) + int(c) + int(python)
    student_info[idx][5] = total
    score_list[i] = total
    return total

def get_avg(idx, total):
    avg = total / 3
    student_info[idx][6] = avg
    return avg

def get_grade(idx, avg):
    if avg >= 90:
        grade = 'A'
    elif avg >= 80:
        grade = 'B'
    elif avg >= 70:
        grade = 'C'
    else:
        grade = 'F'
    student_info[idx][7] = grade
    return grade

def get_rank(score_list):
    rank_list = [sorted(score_list, reverse=True).index(i) for i in score_list]
    return rank_list


def print_info(student_info,rank_list):
    print("성적관리 프로그램")
    print("=======================================================================================================")
    print("{:<10}\t{:<10}\t{:<10}\t{:<10}\t{:<10}\t{:<10}\t{:<10}\t{:<10}\t{:<10}\t".format("학번", "이름", "영어", "c언어", "파이썬", "총점", "평균", "학점", "등수"))
    for j in range(len(student_info)):
        std_num = student_info[j][0]
        eng = student_info[j][2]
        c = student_info[j][3]
        python = student_info[j][4]
        name = student_info[j][1]
        total = student_info[j][5]
        avg = student_info[j][6]
        grade = student_info[j][7]
        rank = rank_list[j]
        print(f"{std_num:<10}\t{name:<10}\t{eng:<10}\t{c:<10}\t{python:<10}\t{total:<10}\t{avg:<10.2f}\t{grade:<10}\t{rank + 1:<10}\t")
    print()

for i in range(lenth):
    print(i+1,"번째 학생의 정보를 입력하세요")
    std_num, name, eng, c, python = get_scores(i, lenth)
    total = get_total(i, eng,c,python)
    avg = get_avg(i, total)
    grade = get_grade(i, avg)
    rank_list = get_rank(score_list)

print_info(student_info, rank_list)

