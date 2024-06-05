import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:boggle/login_page.dart';
import 'package:boggle/services/user_api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _register() async {
    final String nickname = _nicknameController.text;
    final String id = _idController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    final String location = _locationController.text;
    final String email = _emailController.text;

    // 이메일 형식 확인
    if (!_isValidEmail(email)) {
      _showErrorDialog('올바른 이메일 형식이 아닙니다.');
      return;
    }

    // 비밀번호 일치 확인
    if (password != confirmPassword) {
      _showErrorDialog('비밀번호가 일치하지 않습니다.');
      return;
    }

    // 서버로 회원가입 요청 보내기
    final registerResponse = await ApiService.registerUser(id, nickname, password, location, email);

    if (registerResponse.statusCode == 201) {
      // 회원가입 성공 시 로그인 페이지로 이동
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    } else {
      // 회원가입 실패 시 에러 메시지 표시
      final responseBody = jsonDecode(registerResponse.body);
      _showErrorDialog(responseBody['detail'] ?? 'Unknown error');
    }
  }

  bool _isValidEmail(String email) {
    // 이메일 형식 확인하는 정규식
    final RegExp emailRegex = RegExp(r'^[\w-.]+@([\w-]+.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
