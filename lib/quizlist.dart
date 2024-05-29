import 'package:boggle/studyquiz.dart';
import 'package:flutter/material.dart';
import 'package:boggle/quiz.dart';

class Quizlist extends StatelessWidget {
  const Quizlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudyQuiz()),
                );
              },
              child: const Text('퀴즈 공부하기'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Quiz()),
                );
              },
              child: const Text('퀴즈 맞추기'),
            ),
          ],
        ),
      ),
    );
  }
}
