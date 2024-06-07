import 'dart:convert';
import 'dart:io';
import 'package:boggle/sewer_report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Detergent extends StatefulWidget {
  final String title;

  const Detergent({super.key, required this.title});

  @override
  State<Detergent> createState() => _DetergentState();
}

class Task {
  final int id;
  final String work;
  bool isComplete;
  final String imageUrl;

  Task({
    required this.id,
    required this.work,
    required this.isComplete,
    required this.imageUrl,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    String baseUrl = 'http://10.0.2.2:8000'; // Base URL of your Django server
    return Task(
      id: json['id'],
      work: json['work'],
      isComplete: json['isComplete'],
      imageUrl: json['image'] != null ? '$baseUrl${json['image']}' : '',
    );
  }
}

class _DetergentState extends State<Detergent> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _certificationContentController = TextEditingController();
  List<Task> tasks = [];
  bool isModifying = false;
  int modifyingIndex = 0;
  File? _image;

  @override
  void initState() {
    super.initState();
    getTaskFromServer();
  }

  Future<void> getTaskFromServer() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/boggle'));
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> jsonList = json.decode(responseBody);
      List<Task> list = jsonList.map<Task>((json) => Task.fromJson(json)).toList();
      print("로드된 작업 수: ${list.length}");
      setState(() {
        tasks = list;
      });
    } else {
      print("서버에서 작업을 로드하는 데 실패했습니다. 상태 코드: ${response.statusCode}");
      print("응답 본문: ${response.body}");
    }
  }

  Future<void> addTaskToServer(Task task) async {
    if (_image != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8000/boggle/addTask'),
      );

      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

      request.fields['work'] = task.work;
      request.fields['isComplete'] = task.isComplete.toString();

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      print("Response from server: $responseData");

      if (response.statusCode == 200) {
        getTaskFromServer();
      }
    } else {
      print("이미지를 선택하세요.");
    }
  }

  Future<void> updateTaskToServer(int id, String work) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/boggle/updateTask/$id/$work'));
    getTaskFromServer();
    print(response.body);
  }

  Future<void> deleteTaskToServer(int id) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/boggle/deleteTask/$id'));
    getTaskFromServer();
    print(response.body);
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String getToday() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  void navigateToDetailPage(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailPage(task: task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, // Center the title
        title: Text(
          '세제 인증',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0, // Remove shadow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                ' 인증서 작성',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  const Text(
                    '작성시 유의 사항',
                    style: TextStyle(fontSize: 13),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.info_outline,
                      color: Color.fromARGB(255, 196, 42, 250),
                    ),
                    onPressed: () {
                      // Handle info icon press
                    },
                  ),
                ],
              ),
              const SizedBox(height: 3),
              TextField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  hintText: '상품명을 입력하세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _certificationContentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: '인증 내용을 작성하세요. (최대 1000자)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 35),
              const Text(
                '사진 첨부',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: pickImage,
                ),
              ),
              const SizedBox(height: 45), // Added gap
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_image != null || isModifying) {
                      if (isModifying) {
                        await updateTaskToServer(tasks[modifyingIndex].id, _productNameController.text);
                      } else {
                        var task = Task(
                          id: 0,
                          work: _productNameController.text,
                          isComplete: false,
                          imageUrl: '', // 이미지 URL은 서버에서 제공하는 값으로 설정
                        );
                        await addTaskToServer(task);
                      }
                      setState(() {
                        _productNameController.clear();
                        _image = null;
                        isModifying = false;
                      });
                    } else {
                      print("이미지를 선택하세요.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Color.fromARGB(255, 196, 42, 250),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 20% rounded corners
                    ),
                  ),
                  child: const Text(
                    '등록하기',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskDetailPage extends StatelessWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    print('Image URL: ${task.imageUrl}'); // Debug print
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.work,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            task.imageUrl.isNotEmpty
                ? Image.network(
              task.imageUrl,
              height: 300, // Set your desired height here
              width: double.infinity, // Set the width to fill the available space
              fit: BoxFit.cover, // Adjust the image aspect ratio to cover the area
            )
                : const Text('No image available'),
          ],
        ),
      ),
    );
  }
}
