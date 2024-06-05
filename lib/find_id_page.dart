import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FindIDPage extends StatefulWidget {
  const FindIDPage({Key? key}) : super(key: key);

  @override
  _FindIDPageState createState() => _FindIDPageState();
}

class _FindIDPageState extends State<FindIDPage> {
  final TextEditingController _emailController = TextEditingController();
  String? _foundID;

  Future<void> _findID() async {
    final String email = _emailController.text;
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/find_user_id/'), // Django의 API 엔드포인트
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      setState(() {
        _foundID = responseBody['id'];
      });
      _showDialog('ID 찾기 성공', 'ID: $_foundID');
    } else {
      _showDialog('ID 찾기 실패', '일치하는 가입정보가 없습니다.');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
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
        title: const Text('ID 찾기'),
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
                onPressed: _findID,
                child: const Text('ID 찾기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
