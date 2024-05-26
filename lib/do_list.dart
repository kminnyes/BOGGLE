import 'package:boggle/detergent_certification.dart';
import 'package:boggle/quiz.dart';
import 'package:boggle/quizlist.dart';
import 'package:boggle/sewer_repot.dart';
import 'package:boggle/timer.dart';
import 'package:flutter/material.dart';
import 'package:boggle/community.dart';
import 'package:boggle/myhome.dart';
import 'package:boggle/mypage.dart';

class DoList extends StatefulWidget {
  const DoList({super.key});

  @override
  _DoListState createState() => _DoListState();
}
 
class _DoListState extends State<DoList> {
  var _index = 0;

  void _navigateToPage(int index) {
    Widget nextPage;
    switch (index) {
      case 0:
        nextPage = MyHomePage();
        break;
      case 1:
        nextPage = const DoList();
        break;
      case 2:
        nextPage = Community();
        break;
      case 3:
        nextPage =const MyPage();
        break;
      default:
        nextPage = MyHomePage();
    }
    if (ModalRoute.of(context)?.settings.name != nextPage.toString()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            'BOGGLE',
            style: TextStyle(color: Color.fromARGB(255, 147, 159, 248)),
          ),
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
                      minimumSize: const Size(350, 90),
                      backgroundColor:
                          const Color.fromARGB(255, 147, 159, 248),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '실천하기',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    width: 350,
                    height: 420,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 147, 159, 248),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Timer(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(330, 90),
                            backgroundColor: Colors.white,
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
                                builder: (context) => const Detergent(
                                  title: "세제 인증",
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(330, 90),
                            backgroundColor: Colors.white,
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '세제 인증하기',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
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
                                builder: (context) => const SewerReport(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(330, 90),
                            backgroundColor: Colors.white,
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '하수구 신고 하기 ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
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
                                builder: (context) => const Quizlist(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(330, 90),
                            backgroundColor: Colors.white,
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '퀴즈 맞추기',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '물관련 퀴즈 맞추기',
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
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _index = 1;
            });
            _navigateToPage(index);
          },
          currentIndex: 1,
          selectedItemColor: const Color.fromARGB(255, 196, 42, 250),
          unselectedItemColor: const Color.fromARGB(255, 235, 181, 253),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: '실천', icon: Icon(Icons.check_circle)),
            BottomNavigationBarItem(label: '커뮤니티', icon: Icon(Icons.group)),
            BottomNavigationBarItem(label: 'MY', icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}
