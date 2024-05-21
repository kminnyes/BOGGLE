import 'package:flutter/material.dart';
import 'package:boggle/find_id_page.dart';
import 'package:boggle/find_pw_page.dart';
import 'package:boggle/register_page.dart';
import 'package:boggle/do_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final String id = _idController.text;
    final String password = _passwordController.text;

    if (id.isNotEmpty && password.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const DoList();
      }));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("ID와 비밀번호를 입력하세요."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: 'ID',
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: 'PW',
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
                  // onPressed: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(builder: (context)=>const DoList()),
                  //             );
                  //         },
                  //페이지 연결 확인을 위한 임시 코드 
                onPressed: _login,
                child: const Text('로그인'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const FindIDPage();
                        }),
                      );
                    },
                    child: const Text("ID 찾기"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const FindPWPage();
                        }),
                      );
                    },
                    child: const Text("PW 찾기"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const RegisterPage();
                        }),
                      );
                    },
                    child: const Text("회원가입"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
