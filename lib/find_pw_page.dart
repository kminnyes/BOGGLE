import 'package:flutter/material.dart';
import 'package:boggle/login_page.dart';

class FindPWPage extends StatefulWidget {
  const FindPWPage({Key? key}) : super(key: key);

  @override
  _FindPWPageState createState() => _FindPWPageState();
}

class _FindPWPageState extends State<FindPWPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _findPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PW 찾기"),
        centerTitle: true,
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
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                  onPressed: _findPassword,
                  child: const Text('PW 찾기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
