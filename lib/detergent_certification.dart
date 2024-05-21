import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';



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
  final TextEditingController _textController = TextEditingController();
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
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/posting'));
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
        Uri.parse('http://10.0.2.2:8000/posting/addTask'),
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
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/posting/updateTask/$id/$work'));
    getTaskFromServer();
    print(response.body);
  }

  Future<void> deleteTaskToServer(int id) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/posting/deleteTask/$id'));
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



  // 기존 코드와 동일

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(getToday()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _textController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: pickImage,
                      child: const Text('이미지 선택'),
                    ),
                    _image != null
                        ? GestureDetector(
                            onTap: pickImage,
                            child: Image.file(
                              _image!,
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.8,
                            ),
                          )
                        : const Text('이미지가 선택되지 않았습니다.'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_image != null || isModifying) {
                          if (isModifying) {
                            await updateTaskToServer(tasks[modifyingIndex].id, _textController.text);
                          } else {
                            var task = Task(
                              id: 0,
                              work: _textController.text,
                              isComplete: false,
                              imageUrl: '', // 이미지 URL은 서버에서 제공하는 값으로 설정
                            );
                            await addTaskToServer(task);
                          }
                          setState(() {
                            _textController.clear();
                            _image = null;
                            isModifying = false;
                          });
                        } else {
                          print("이미지를 선택하세요.");
                        }
                      },
                      child: Text(isModifying ? "Update" : "Add"),
                    ),
                  ],
                ),
              ),
             
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                     
                      title: GestureDetector(
                        onTap: () {
                          navigateToDetailPage(task);
                        },
                        child: Text(
                          task.work,
                          softWrap: true,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _textController.text = task.work;
                                isModifying = true;
                                modifyingIndex = index;
                              });
                            },
                            child: const Text("수정"),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                deleteTaskToServer(task.id);
                              });
                            },
                            child: const Text("삭제"),
                          ),
                        ],
                      ),
                    );
                  },
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

