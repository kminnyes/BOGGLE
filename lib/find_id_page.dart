import 'package:flutter/material.dart';

class FindIDPage extends StatefulWidget {
  const FindIDPage({super.key});

  @override
  State<FindIDPage> createState() => _FindIDPageState();
}

class _FindIDPageState extends State<FindIDPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ID 찾기"),
          centerTitle: true,
        ),
        body: Container());
  }
}