import 'package:flutter/material.dart';
import 'package:boggle/do_list.dart';
import 'package:boggle/myhome.dart';
import 'package:boggle/mypage.dart';
import 'package:google_fonts/google_fonts.dart';

class Community extends StatefulWidget {
  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  var _index = 2; // 페이지 인덱스 0,1,2,3

  // 페이지 이동 함수
  void _navigateToPage(int index) {
    Widget nextPage;
    switch (index) {
      case 0:
        nextPage = MyHomePage();
        break;
      case 1:
        nextPage = DoList();
        break;
      case 2:
        nextPage = Community();
        break;
      case 3:
        nextPage = MyPage();
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
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
        child: Text(
          '커뮤니티',
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
        selectedItemColor: Color.fromARGB(255, 196, 42, 250),
        unselectedItemColor: Color.fromARGB(255, 235, 181, 253),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '실천', icon: Icon(Icons.check_circle)),
          BottomNavigationBarItem(label: '커뮤니티', icon: Icon(Icons.group)),
          BottomNavigationBarItem(label: 'MY', icon: Icon(Icons.person))
        ],
      ),
    );
  }
}
