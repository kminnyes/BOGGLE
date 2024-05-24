import 'package:boggle/detergent_certification.dart';
import 'package:boggle/quiz.dart';
import 'package:boggle/sewer_repot.dart';
import 'package:boggle/timer.dart';
import 'package:flutter/material.dart';

class DoList extends StatelessWidget {
  const DoList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(350, 100),
                      backgroundColor:
                          const Color.fromARGB(255, 147, 159, 248), // 수정된 부분
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '인증 내역 확인하기',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white, // 흰색 텍스트로 변경
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // 위젯 간격 조절
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10), // 적당한 margin 설정
                    width: 350, // 컨테이너의 너비 설정
                    height: 450, // 컨테이너의 높이 설정
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 147, 159, 248), // 수정된 부분
                      borderRadius:
                          BorderRadius.circular(20), // 컨테이너의 경계를 둥글게 설정
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Timer()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(330, 100),
                            backgroundColor: Colors.white, // 수정된 부분
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '타이머 기록하기',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '손씻기, 샤워하기, 설거지',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Detergent(title: "세제 인증")),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(330, 100),
                            backgroundColor: Colors.white, // 수정된 부분
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '세제 인증하기',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black, // 수정된 부분
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '친환경 세제 인증',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SewerReport()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(330, 100),
                            backgroundColor: Colors.white, // 수정된 부분
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '하수구 신고 하기 ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black, // 수정된 부분
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '하수구 빗물받이 불편 신고 인증',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Quiz()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(330, 100),
                            backgroundColor: Colors.white, // 수정된 부분
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '퀴즈 맞추기',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black, // 수정된 부분
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Water-related Quiz',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
