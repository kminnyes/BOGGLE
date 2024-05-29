import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SewerReport extends StatefulWidget {
  final String title;

  const SewerReport({super.key, required this.title});

  @override
  State<SewerReport> createState() => _SewerReportState();
}

class Report {
  final int id;
  final String work;
  final String imageUrl;

  Report({
    required this.id,
    required this.work,
    required this.imageUrl,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    String baseUrl = 'http://10.0.2.2:8000'; // Base URL of your Django server
    return Report(
      id: json['id'],
      work: json['work'],
      imageUrl: json['image'] != null ? '$baseUrl${json['image']}' : '',
    );
  }
}

class _SewerReportState extends State<SewerReport> {
  final TextEditingController _textController = TextEditingController();
  List<Report> reports = [];
  bool isModifying = false;
  int modifyingIndex = 0;
  File? _image;

  @override
  void initState() {
    super.initState();
    getReportFromServer();
  }

  Future<void> getReportFromServer() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/getReportList'));
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> jsonList = json.decode(responseBody);
      List<Report> list = jsonList.map<Report>((json) => Report.fromJson(json)).toList();
      print("Loaded tasks: ${list.length}");
      setState(() {
        reports = list;
      });
    } else {
      print("Failed to load tasks from server. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  }

  Future<void> addReportToServer(Report report) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://10.0.2.2:8000/addReport'), // Ensure the URL matches the backend endpoint
  );

  if (_image != null) {
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
  }

  request.fields['work'] = report.work;

  var response = await request.send();
  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('신고 접수되었습니다'), // Here's the message
      ),
    );
    getReportFromServer();
  } else {
    print("Failed to add report. Status code: ${response.statusCode}");
  }
}

  Future<void> updateReportToServer(int id, String work) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://10.0.2.2:8000/updateReport/$id/'), // Use POST for updating
  );

  request.fields['work'] = work;

  var response = await request.send();
  if (response.statusCode == 200) {
    getReportFromServer();
  } else {
    print("Failed to update report. Status code: ${response.statusCode}");
  }
}

Future<void> deleteReportToServer(int id) async {
  final response = await http.delete(Uri.parse('http://10.0.2.2:8000/deleteReport/$id/'));
  if (response.statusCode == 200) {
    getReportFromServer();
  } else {
    print("Failed to delete report. Status code: ${response.statusCode}");
  }
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

  void navigateToDetailPage(Report report) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportDetailPage(report: report),
      ),
    );
  }

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
                      child: const Text('사진'),
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
                        : const Text('사진 선택하기'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_image != null || isModifying) {
                          if (isModifying) {
                            await updateReportToServer(reports[modifyingIndex].id, _textController.text);
                          } else {
                            var task = Report(
                              id: 0,
                              work: _textController.text,
                              imageUrl: '',
                            );
                            await addReportToServer(task);
                          }
                          setState(() {
                            _textController.clear();
                            _image = null;
                            isModifying = false;
                          });
                        } else {
                          print("Please select an image.");
                        }
                      },
                      child: Text(isModifying ? "Update" : "신고하기"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    final report = reports[index];
                    return ListTile(
                      title: GestureDetector(
                        onTap: () {
                          navigateToDetailPage(report);
                        },
                        child: Text(
                          report.work,
                          softWrap: true,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _textController.text = report.work;
                                isModifying = true;
                                modifyingIndex = index;
                              });
                            },
                            child: const Text("수정"),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                deleteReportToServer(report.id);
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

class ReportDetailPage extends StatelessWidget {
  final Report report;

  const ReportDetailPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    print('Image URL: ${report.imageUrl}'); // Debug print
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
              report.work,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            report.imageUrl.isNotEmpty
                ? Image.network(
                    report.imageUrl,
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
