import 'package:flutter/material.dart';
import 'package:boggle/login_page.dart';

class FindIDPage extends StatefulWidget {
  const FindIDPage({super.key});

  @override
  State<FindIDPage> createState() => _FindIDPageState();
}

class _FindIDPageState extends State<FindIDPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ID 찾기"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
              width: 300,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(199, 166, 233, 1),
                  foregroundColor: Colors.white,
                ),
                  onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>const LoginPage()),
                              );
                          },
                  //페이지 연결 확인을 위한 임시 코드 
                //onPressed: _login,
                child: const Text('ID 찾기'),
              ),
            ),
          ],),
        ));
  }
}