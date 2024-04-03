# 소프트웨어학과 2021041091 윤별
# 20240403 tic-tac-toe 게임

def draw_board(board):
    for r in range(3):
        print(" " + " | ".join(board[r]))
        if r < 2:
            print("---|---|---")

def check_winner(board):
    # 가로, 세로, 대각선 방향 승자를 확인
    for i in range(3):
        if board[i][0] == board[i][1] == board[i][2] != ' ':
            draw_board(board)
            return board[i][0]
        if board[0][i] == board[1][i] == board[2][i] != ' ':
            draw_board(board)
            return board[0][i]
    if board[0][0] == board[1][1] == board[2][2] != ' ':
        draw_board(board)
        return board[0][0]
    if board[0][2] == board[1][1] == board[2][0] != ' ':
        draw_board(board)
        return board[0][2]
    return None

def get_next_move(board):
    # 컴퓨터가 놓을 위치를 결정하고 비어있는 칸에 놓는다.
    for i in range(3):
        for j in range(3):
            if board[i][j] == ' ':
                return i, j

board = [[' ' for x in range(3)] for y in range(3)]

while True:
    draw_board(board)

    # 사용자로부터 좌표를 입력
    x = int(input("다음 수의 x좌표를 입력하시오: "))
    y = int(input("다음 수의 y좌표를 입력하시오: "))

    # 사용자가 입력한 좌표를 검사
    if board[x][y] != ' ':
        print("잘못된 위치입니다. ")
        continue
    else:
        board[x][y] = 'X'

    # 보드가 다 찼는지 확인
    board_full = all(board[i][j] != ' ' for i in range(3) for j in range(3))
    if board_full:
        print("무승부입니다!")
        break
    else:
        # 컴퓨터의 차례
        x, y = get_next_move(board)
        board[x][y] = 'O'

        # 게임 종료 조건 확인
        winner = check_winner(board)
        if winner == 'X':
            print(f"사용자가 이겼습니다!")
            break
        elif winner == 'O':
            print(f"컴퓨터가 이겼습니다!")
            break

