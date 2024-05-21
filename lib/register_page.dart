import 'package:flutter/material.dart';
import 'package:boggle/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _register() {
    final String nickname = _nicknameController.text;
    final String id = _idController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    final String location = _locationController.text;
    final String email = _emailController.text;

    // 회원가입 로직 추가하기
    // 여기에 필요한 유효성 검사 등을 포함할 수 있습니다.

    print('Nickname: $nickname');
    print('ID: $id');
    print('Password: $password');
    print('Confirm Password: $confirmPassword');
    print('Location: $location');
    print('Email: $email');

    // 회원가입 성공 후 로그인 페이지로 이동
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(labelText: '닉네임'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: '아이디'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '비밀번호'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '비밀번호 확인'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: '지역'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(199, 166, 233, 1),
                foregroundColor: Colors.white,
              ),
              onPressed: _register,
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}