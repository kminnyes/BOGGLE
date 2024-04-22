# 소프트웨어학과 2021041091 윤별
# 20240417 성적관리프로그램 (클래스 활용)
class Student:
    def __init__(self, std_num, name, eng, c, python):
        self.std_num = std_num
        self.name = name
        self.eng = int(eng)
        self.c = int(c)
        self.python = int(python)
        self.total = self.eng + self.c + self.python
        self.avg = self.total / 3
        self.grade = self.get_grade()

    def get_grade(self):
        if self.avg >= 90:
            return 'A'
        elif self.avg >= 80:
            return 'B'
        elif self.avg >= 70:
            return 'C'
        else:
            return 'F'

    def __str__(self):
        return f"학번 : {self.std_num:<5}\t이름 : {self.name:<5}\t영어 성적 : {self.eng:<5}\tC-언어 성적 : {self.c:<5}\t파이썬 성적 : {self.python:<5}\t총점 : {self.total:<5}\t평균 : {self.avg:<5.2f}\t학점 : {self.grade:<5}"


class ScoreManager:
    def __init__(self):
        self.students_info = []
        self.total80_cnt = 0

    def add_student(self, student):
        self.students_info.append(student)
        if student.total >= 240:
            self.total80_cnt += 1

    def delete_student(self, std_num):
        for student in self.students_info:
            if student.std_num == std_num:
                self.students_info.remove(student)
                if student.total >= 240:
                    self.total80_cnt -= 1
                return True
        return False

    def find_student(self, std_num, name):
        for student in self.students_info:
            if student.std_num == std_num and student.name == name:
                return student
        return None

    def sort_students_by_total(self):
        self.students_info.sort(key=lambda x: x.total, reverse=True)

    def print_students_info(self):
        print("성적관리 프로그램")
        print("=" * 90)
        print("{:<10}\t{:<10}\t{:<13}\t{:<15}\t{:<15}\t{:<7}\t{:<7}\t{:<7}\t{:<7}".format("학번", "이름", "영어", "c언어", "파이썬", "총점", "평균", "학점", "등수"))
        rank_list = self.get_rank()
        for student, rank in zip(self.students_info, rank_list):
            print(student, f"등수: {rank:<5}")
        print()

    def get_rank(self):
        sorted_scores = sorted([student.total for student in self.students_info], reverse=True)
        return [sorted_scores.index(student.total) + 1 for student in self.students_info]

    def upper80_print(self):
        print(f"80점 이상 맞은 학생의 수: {self.total80_cnt}\n")


class Menu:
    def show_menu(self):
        print("=============성적 관리 프로그램=============")
        print("메뉴")
        print("1. 학생 정보 입력")
        print("2. 학생 삭제")
        print("3. 학생 정보 찾기")
        print("4. 총점으로 학생 목록 정렬")
        print("5. 80점 이상 맞은 학생수 조회")
        print("6. 전체 학생의 성적 조회")
        print("7. 종료")


class ScoreManagementSystem:
    def __init__(self):
        self.score_manager = ScoreManager()
        self.menu = Menu()

    def run(self):
        while True:
            self.menu.show_menu()
            menu_num = input("실행할 메뉴 번호 입력 >>> ")
            if menu_num == '1':
                self.add_student_info()
            elif menu_num == '2':
                self.delete_student_info()
            elif menu_num == '3':
                self.find_student_info()
            elif menu_num == '4':
                self.score_manager.sort_students_by_total()
            elif menu_num == '5':
                self.score_manager.upper80_print()
            elif menu_num == '6':
                self.score_manager.print_students_info()
            elif menu_num == '7':
                print("성적 관리 프로그램을 종료하겠습니다.")
                break

    def add_student_info(self):
        std_num = input("학번: ")
        name = input("이름: ")
        eng = input("영어 성적: ")
        c = input("C-언어 성적: ")
        python = input("파이썬 성적: ")
        student = Student(std_num, name, eng, c, python)
        self.score_manager.add_student(student)

    def delete_student_info(self):
        std_num = input("삭제할 학생의 학번을 입력하세요: ")
        if self.score_manager.delete_student(std_num):
            print(f"{std_num} 학번의 학생 정보가 삭제되었습니다.\n")
        else:
            print("해당 학번의 학생을 찾을 수 없습니다.\n")

    def find_student_info(self):
        std_num, name = input("찾을 학생의 학번과 이름을 입력하세요 (띄어쓰기로 구분): ").split()
        student = self.score_manager.find_student(std_num, name)
        if student:
            print(student)
        else:
            print("해당하는 학생을 찾을 수 없습니다.\n")


score_system = ScoreManagementSystem()
score_system.run()
