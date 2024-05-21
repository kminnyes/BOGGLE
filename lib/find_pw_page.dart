import 'package:flutter/material.dart';

class FindPWPage extends StatefulWidget {
  const FindPWPage({super.key});

  @override
  State<FindPWPage> createState() => _FindPWPageState();
}

class _FindPWPageState extends State<FindPWPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PW 찾기"),
          centerTitle: true,
        ),
        body: Container());
  }
}