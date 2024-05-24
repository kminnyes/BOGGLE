import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:boggle/myhome.dart';
import 'package:boggle/do_list.dart';
import 'package:boggle/community.dart';
import 'package:boggle/mypage.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<dynamic> _quizData = [];
  int _currentQuizIndex = 0;
  String _userAnswer = '';
  String _resultMessage = '';
  int _correctAnswers = 0;
  bool _isQuizCompleted = false;
  int _selectedIndex = 0;

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
      });
    } else {
      throw Exception('Failed to load quiz data');
    }
  }

  Future<void> _checkAnswer(String question, String answer) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/check_answer/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'question': question,
        'answer': answer,
      }),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      setState(() {
        if (result['result'] == 'correct') {
          _resultMessage = 'Correct!';
          _correctAnswers++;
        } else {
          _resultMessage = 'Incorrect!';
        }

        if (_currentQuizIndex < _quizData.length - 1) {
          _currentQuizIndex++;
        } else {
          _isQuizCompleted = true;
          _resultMessage += '\n\nQuiz completed! You got $_correctAnswers out of ${_quizData.length} correct.';
        }
        _userAnswer = '';
      });
    } else {
      throw Exception('Failed to check answer');
    }
  }

  void _navigateToPage(int index) {
    Widget nextPage;
    switch (index) {
      case 0:
        nextPage = MyHomePage();
        break;
      case 1:
        nextPage =  const DoList();
        break;
      case 2:
        nextPage = Community();
        break;
      case 3:
        nextPage = const MyPage();
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
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            'BOGGLE',
            style: TextStyle(color: Color.fromARGB(255, 147, 159, 248)),
          ),
          centerTitle: true,
        ),
      body: _isQuizCompleted ? _buildScorePage() : _buildQuizPage(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _navigateToPage(index);
        },
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 196, 42, 250),
        unselectedItemColor: const Color.fromARGB(255, 235, 181, 253),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '실천', icon: Icon(Icons.check_circle)),
          BottomNavigationBarItem(label: '커뮤니티', icon: Icon(Icons.group)),
          BottomNavigationBarItem(label: 'MY', icon: Icon(Icons.person)),
        ],
      ),
    );
  }

Widget _buildQuizPage() {
  return _quizData.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _quizData[_currentQuizIndex]['explain'],
                style: const TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  _userAnswer = value;
                },
                decoration: const InputDecoration(
                  labelText: '정답을 입력하세요',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _checkAnswer(_quizData[_currentQuizIndex]['explain'], _userAnswer),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24), backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '확인하기',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _resultMessage,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
}


Widget _buildScorePage() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle_outline,
          size: 80,
          color: Colors.purple,
        ),
        const SizedBox(height: 20),
        const Text(
          '퀴즈 완료!',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        Text(
          '$_correctAnswers / ${_quizData.length} 정답',
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CorrectAnswersPage(quizData: _quizData),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24), backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            '정답 확인하기',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

}
class CorrectAnswersPage extends StatelessWidget {
  final List<dynamic> quizData;

  const CorrectAnswersPage({super.key, required this.quizData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('정답 확인하기'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: quizData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 4, // Add elevation for a shadow effect
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quizData[index]['explain'],
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '정답: ${quizData[index]['hNm']}',
                    style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
