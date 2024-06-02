import 'dart:ui';

import 'package:boggle/community.dart';
import 'package:boggle/do_list.dart';
import 'package:boggle/myhome.dart';
import 'package:boggle/mypage.dart';
import 'package:boggle/studyquiz.dart';
import 'package:flutter/material.dart';
import 'package:boggle/quiz.dart';
import 'package:google_fonts/google_fonts.dart';

class Quizlist extends StatefulWidget {
  const Quizlist({super.key});

  @override
  _QuizlistState createState() => _QuizlistState();
}

class _QuizlistState extends State<Quizlist> {
  var _index = 1; // 페이지 인덱스 0,1,2,3

  // 페이지 이동 함수
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
        nextPage = const MyPage();
        break;
      default:
        nextPage = MyHomePage();
    }
    if (ModalRoute.of(context)?.settings.name != nextPage.toString()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => nextPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(
          ' BOGGLE',
          style: GoogleFonts.londrinaSolid(
              fontSize:27,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 196, 42, 250)
          ),
        ),
        centerTitle: false,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:const Color.fromARGB(255, 235, 181, 253), // Button color
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                minimumSize: const Size(200, 60), 
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.black, // Shadow color
                elevation: 8, // Elevation for shadow
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudyQuiz()),
                );
              },
              child: const Text('퀴즈 공부하기'),
            ),
            const SizedBox(height: 20), // Add space between buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 235, 181, 253), // Button color
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                minimumSize: const Size(200, 60), // Button size
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.black, // Shadow color
                elevation: 7, // Elevation for shadow
              ),
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = 1;
          });
          _navigateToPage(index);
        },
        currentIndex: _index,
        selectedItemColor: const Color.fromARGB(255, 196, 42, 250),
        unselectedItemColor: const Color.fromARGB(255, 235, 181, 253),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '실천', icon: Icon(Icons.checklist)),
          BottomNavigationBarItem(label: '커뮤니티', icon: Icon(Icons.people)),
          BottomNavigationBarItem(label: 'MY', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
