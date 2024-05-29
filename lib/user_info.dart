import 'package:flutter/material.dart';
import 'package:boggle/do_list.dart';
import 'package:boggle/myhome.dart';
import 'package:boggle/mypage.dart';
import 'package:boggle/community.dart';


class UserInfo extends StatefulWidget {
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


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
          'BOGGLE',
          style: TextStyle(color: Color.fromARGB(255, 147, 159, 248)),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _idController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                    contentPadding: EdgeInsets.all(8),
                  ),),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _nicknameController,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: '닉네임',
                    contentPadding: EdgeInsets.all(8),
                  ),),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: '지역',
                    contentPadding: EdgeInsets.all(8),
                  ),),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'emaiil',
                    contentPadding: EdgeInsets.all(8),
                  ),),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(199, 166, 233, 1),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text('회원정보 수정'),
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
          BottomNavigationBarItem(label: '실천', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '커뮤니티', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'MY', icon: Icon(Icons.home))
        ],
      ),
    );
  }
}