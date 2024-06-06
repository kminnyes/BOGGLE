import 'package:flutter/material.dart';
import 'package:boggle/do_list.dart';
import 'package:boggle/myhome.dart';
import 'package:boggle/mypage.dart';
import 'package:boggle/community.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePW extends StatefulWidget {
  final String userId;

  const ChangePW({Key? key, required this.userId}) : super(key: key);

  @override
  State<ChangePW> createState() => _ChangePWState();
}

class _ChangePWState extends State<ChangePW> {
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _newPWController = TextEditingController();
  final TextEditingController _confirmPWController = TextEditingController();

  @override
  var _index = 3; // 페이지 인덱스 0,1,2,3

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          ' BOGGLE',
          style: GoogleFonts.londrinaSolid(
              fontSize: 27,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 196, 42, 250)),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
              width: 300,
              child: Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: Text(
                    '현재 비밀번호',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),  
            ),
            const SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _pwController,
                  decoration: const InputDecoration(
                    filled: true, 
                    fillColor: Colors.white,                   
                    border: OutlineInputBorder(),
                    hintText: '현재 비밀번호를 입력해주세요',
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(
              width: 300,
              child: Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: Text(
                    '새로운 비밀번호',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),  
            ),
            const SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _newPWController,
                  decoration: const InputDecoration(
                    filled: true, 
                    fillColor: Colors.white,                   
                    border: OutlineInputBorder(),
                    hintText: '새로운 비밀번호를 입력해주세요',
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
              width: 300,
              child: Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: Text(
                    '새로운 비밀번호 확인',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),  
            ),
            const SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _confirmPWController,
                  decoration: const InputDecoration(
                    filled: true, 
                    fillColor: Colors.white,                   
                    border: OutlineInputBorder(),
                    hintText: '새로운 비밀번호를 한번 더 입력해주세요',
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC42AFA),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),),
                  onPressed: () {},
                  child: const Text('비밀번호 수정'),
                ),
              ),
            ],
          ),
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
          BottomNavigationBarItem(
              label: '실천', icon: Icon(Icons.volunteer_activism)),
          BottomNavigationBarItem(
              label: '커뮤니티', icon: Icon(Icons.mark_chat_unread)),
          BottomNavigationBarItem(
              label: 'MY', icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
}
