import 'package:boggle/community.dart';
import 'package:boggle/do_list.dart';
import 'package:boggle/myhome.dart';
import 'package:boggle/mypage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'quiz.dart'; // Quiz 페이지 import

class StudyQuiz extends StatefulWidget {
  final String userId;

  const StudyQuiz({Key? key, required this.userId}) : super(key: key);

  @override
  State<StudyQuiz> createState() => _StudyQuizState();
}

class _StudyQuizState extends State<StudyQuiz> {
  var _index = 1; // 페이지 인덱스 0,1,2,3

  // 페이지 이동 함수
  void _navigateToPage(int index) {
    Widget nextPage;
    switch (index) {
      case 0:
        nextPage = MyHomePage(userId: widget.userId);
        break;
      case 1:
        nextPage = DoList(userId: widget.userId);
        break;
      case 2:
        nextPage = Community(userId: widget.userId);
        break;
      case 3:
        nextPage = MyPage(userId: widget.userId);
        break;
      default:
        nextPage = MyHomePage(userId: widget.userId);
    }
    if (ModalRoute.of(context)?.settings.name != nextPage.toString()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => nextPage));
    }
  }
  List<dynamic> _quizData = [];
  int _currentQuizIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuizData();
  }

  Future<void> _fetchQuizData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/quiz_data_api'));
    if (response.statusCode == 200) {
      setState(() {
        _quizData = json.decode(response.body);
        _currentQuizIndex = 0; // Reset index for new set of quizzes
      });
    } else {
      throw Exception('Failed to load quiz data');
    }
  }

  void _nextQuiz() {
    setState(() {
      if (_currentQuizIndex < _quizData.length - 1) {
        _currentQuizIndex++;
      }
    });
  }

  void _previousQuiz() {
    setState(() {
      if (_currentQuizIndex > 0) {
        _currentQuizIndex--;
      }
    });
  }

  void _navigateToQuizPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Quiz(userId: widget.userId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' BOGGLE',
          style: GoogleFonts.londrinaSolid(
              fontSize:27,
              fontWeight: FontWeight.normal,
              color: const Color.fromARGB(255, 196, 42, 250)
          ),
        ),
      
      ),
      body: _quizData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Quizzes: ${_quizData.length}',
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _quizData[_currentQuizIndex]['explain'],
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '정답: ${_quizData[_currentQuizIndex]['hNm']}',
                    style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _previousQuiz,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          backgroundColor: const Color.fromARGB(255, 191, 116, 201),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '이전',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _nextQuiz,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          backgroundColor:  const Color.fromARGB(255, 100, 16, 111),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '다음',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  if (_currentQuizIndex == _quizData.length - 1) // Show buttons only after finishing the quizzes
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: _fetchQuizData,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            '더 학습하기',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _navigateToQuizPage,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            backgroundColor: const Color.fromARGB(255, 97, 151, 209),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            '퀴즈 맞추러 가기',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
             bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
          _navigateToPage(index);
        },
        currentIndex: _index,
        selectedItemColor: const Color.fromARGB(255, 196, 42, 250),
        unselectedItemColor: const Color.fromARGB(255, 235, 181, 253),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '실천', icon: Icon(Icons.check_circle)),
          BottomNavigationBarItem(label: '커뮤니티', icon: Icon(Icons.group)),
          BottomNavigationBarItem(label: 'MY', icon: Icon(Icons.person))
        ],
      ),
    );
  }
}
