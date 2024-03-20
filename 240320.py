num = int(input("학생의 수를 입력하세요 >>> "))
score_list = [0] * num
for i in range(num):
    print(i+1,"번째 학생의 성적을 입력하세요")
    eng = int(input("영어 성적을 입력하세요 >>> "))
    c = int(input("C-언어 성적을 입력하세요 >>> "))
    python = int(input("파이썬 성적을 입력하세요 >>> "))
    total = eng + c + python
    score_list[i] = total

rank_list = [sorted(score_list, reverse=True).index(i) for i in score_list]

for j in range(num):
    avg = score_list[j] / 3
    if avg >= 90:
        grade = 'A'
    elif avg >= 80:
        grade = 'B'
    elif avg >= 70:
        grade = 'C'
    else:
        grade = 'F'
    print(f"{j+1}번째 학생의 총점은 {score_list[j]}, 평균은 {avg:.2f}, 학점은 {grade}, 등수는 {rank_list[j]+1}등 입니다.")
