import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
          _resultMessage = 'Incorrect! The correct answer is: ${_quizData[_currentQuizIndex]['hNm']}';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: _isQuizCompleted
          ? _buildScorePage()
          : _buildQuizPage(),
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
                  style: const TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  onChanged: (value) {
                    _userAnswer = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter your answer',
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _checkAnswer(_quizData[_currentQuizIndex]['explain'], _userAnswer),
                  child: const Text('Submit Answer'),
                ),
                Text(_resultMessage),
              ],
            ),
          );
  }

  Widget _buildScorePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Quiz completed!',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'You got $_correctAnswers out of ${_quizData.length} correct.',
            style: const TextStyle(fontSize: 18.0),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CorrectAnswersPage(quizData: _quizData),
                ),
              );
            },
            child: const Text('View Correct Answers'),
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
        title: const Text('Correct Answers'),
      ),
      body: ListView.builder(
        itemCount: quizData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(quizData[index]['explain']),
            subtitle: Text('Correct Answer: ${quizData[index]['hNm']}'),
          );
        },
      ),
    );
  }
}
