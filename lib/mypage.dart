import 'package:flutter/material.dart';
import 'package:boggle/do_list.dart';
import 'package:boggle/myhome.dart';
import 'package:boggle/community.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  var _index = 3; // 페이지 인덱스 0,1,2,3

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
        title: const Text(
          'BOGGLE',
          style: TextStyle(color: Color.fromARGB(255, 147, 159, 248)),
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text(
          'MY',
          style: TextStyle(fontSize: 40),
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
          BottomNavigationBarItem(label: '실천', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '커뮤니티', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'MY', icon: Icon(Icons.home))
        ],
      ),
    );
  }
}
