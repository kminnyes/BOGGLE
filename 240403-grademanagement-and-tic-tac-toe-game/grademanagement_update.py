# 소프트웨어학과 2021041091 윤별
# 성적관리프로그램 (리스트 함수 활용)
rows = 5    # 학생수
cols = 8    # 학번(0), 이름(1), 영어(2), c언어(3), 파이썬(4), 총점(5), 평균(6), 학점(7)
students_info = []  # 학생 전체 리스트 -> 2차원으로 활용 예정
student_info = []   # 학생 한명의 정보를 담은 리스트
score_list = []
total80_cnt = 0
student_cnt = 0
val = True
def get_scores():
    print(f"{student_cnt}번째 학생의 정보를 입력하세요")
    std_num = input("학번: ")
    name = input("이름: ")
    eng = input("영어 성적: ")
    c = input("C-언어 성적: ")
    python = input("파이썬 성적: ")
    return std_num, name, eng, c, python

def get_total(eng, c, python):
    return int(eng) + int(c) + int(python)

def get_avg(total):
    return total / 3

def get_grade(avg):
    global total80_cnt
    if avg >= 90:
        grade = 'A'
        total80_cnt += 1
    elif avg >= 80:
        grade = 'B'
        total80_cnt += 1
    elif avg >= 70:
        grade = 'C'
    else:
        grade = 'F'
    return grade

def get_rank(score_list):
    sorted_scores = sorted(score_list, reverse=True)
    return [sorted_scores.index(i) + 1 for i in score_list]

def print_info(students_info, rank_list):
    print("성적관리 프로그램")
    print("=" * 118)
    print("{:<10}\t{:<10}\t{:<10}\t{:<10}\t{:<10}\t{:<10}\t{:<10}\t{:<10}\t{:<10}".format("학번", "이름", "영어", "c언어", "파이썬", "총점", "평균", "학점", "등수"))
    for student, rank in zip(students_info, rank_list):
        std_num, name, eng, c, python, total, avg, grade = student
        print(f"{std_num:<10}\t{name:<10}\t{eng:<10}\t{c:<10}\t{python:<10}\t{total:<10}\t{avg:<10.2f}\t{grade:<10}\t{rank:<10}")
    print()

def upper80_print():
    global total80_cnt
    print(f"80점 이상 맞은 학생의 수: {total80_cnt}\n")

def find_student():
    global students_info
    std_num, name = input("찾을 학생의 학번과 이름을 입력하세요 (띄어쓰기로 구분): ").split()
    for student in students_info:
        if student[0] == std_num and student[1] == name:
            print(f"학번 : {student[0]:<10}\t이름 : {student[1]:<10}\t영어 성적 : {student[2]:<10}\tC-언어 성적 : {student[3]:<10}\t파이썬 성적 : {student[4]:<10}\t총점 : {student[5]:<10}\t평균 : {student[6]:<10.2f}\t학점 : {student[7]:<10}\n")
            return
    print("해당하는 학생을 찾을 수 없습니다.\n")

def delete_student():
    global students_info, total80_cnt
    std_num = input("삭제할 학생의 학번을 입력하세요: ")
    for student in students_info:
        if student[0] == std_num:
            if int(student[5]) >= 240:
                total80_cnt -= 1
            students_info.remove(student)
            print(f"{std_num} 학번의 학생 정보가 삭제되었습니다.\n")
            return
    print("해당 학번의 학생을 찾을 수 없습니다.\n")

def sort_students_by_total():
    global students_info
    students_info.sort(key=lambda x: x[5], reverse=True)

def menu():
    print("=============성적 관리 프로그램=============")
    print("메뉴")
    print("1. 학생 정보 입력")
    print("2. 학생 삭제")
    print("3. 학생 정보 찾기")
    print("4. 총점으로 학생 목록 정렬")
    print("5. 80점 이상 맞은 학생수 조회")
    print("6. 전체 학생의 성적 조회")
    print("7. 종료")

def op(num):
    global val, student_cnt
    if num == '1':
        student_cnt += 1
        std_num, name, eng, c, python = get_scores()
        total = get_total(eng, c, python)
        avg = get_avg(total)
        grade = get_grade(avg)
        students_info.append([std_num, name, eng, c, python, total, avg, grade])
        score_list.append(total)
    elif num == '2':
        delete_student()
    elif num == '3':
        find_student()
    elif num == '4':
        sort_students_by_total()
    elif num == '5':
        upper80_print()
    elif num == '6':
        rank_list = get_rank(score_list)
        print_info(students_info, rank_list)
    elif num == '7':
        print("성적 관리 프로그램을 종료하겠습니다.")
        val = False

while val:
    menu()
    menu_num = input("실행할 메뉴 번호 입력 >>> ")
    op(menu_num)
