# 윤별 20240320 성적관리프로그램
rows = 5    # 학생수
cols = 8    # 학번(0), 이름(1), 영어(2), c언어(3), 파이썬(4), 총점(5), 평균(6), 학점(7)
student_info = [[0 for j in range(cols)] for i in range(rows)]
score_list = [0] * 5
lenth = len(student_info)

for i in range(lenth):
    print(i+1,"번째 학생의 정보를 입력하세요")
    std_num = input("학생의 학번을 입력하세요 >>> ")
    name = input("학생의 이름을 입력하세요 >>> ")
    eng = input("영어 성적을 입력하세요 >>> ")
    c = input("C-언어 성적을 입력하세요 >>> ")
    python = input("파이썬 성적을 입력하세요 >>> ")
    total = int(eng) + int(c) + int(python)
    student_info[i][0] = std_num
    student_info[i][1] = name
    student_info[i][2] = eng
    student_info[i][3] = c
    student_info[i][4] = python
    student_info[i][5] = total
    score_list[i]= total
    avg = round(total/3,2)
    student_info[i][6] = str(avg)
    if avg >= 90:
        grade = 'A'
    elif avg >= 80:
        grade = 'B'
    elif avg >= 70:
        grade = 'C'
    else:
        grade = 'F'
    student_info[i][7] = grade

rank_list = [sorted(score_list, reverse=True).index(i) for i in score_list]

print("{:7}{:7}{:7}{:7}{:7}{:7}{:7}{:7}{:7}".format("학번","이름","영어성적","c언어","파이썬","총점","평균","학점","등수"))
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
    print(f"{std_num:7}\t{name:7}\t{eng:7}\t{c:7}\t{python:7}\t{total:7}\t{avg:7}\t{grade:7}\t{rank+1:7}\t")
