import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'quiz.dart'; // Quiz 페이지 import

class StudyQuiz extends StatefulWidget {
  const StudyQuiz({super.key});

  @override
  _StudyQuizState createState() => _StudyQuizState();
}

class _StudyQuizState extends State<StudyQuiz> {
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
      MaterialPageRoute(builder: (context) => const Quiz()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Quiz'),
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
                          backgroundColor: Colors.purple,
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
                          backgroundColor: Colors.blue,
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
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            '더 학습하기',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _navigateToQuizPage,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            backgroundColor: Colors.red,
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
    );
  }
}
