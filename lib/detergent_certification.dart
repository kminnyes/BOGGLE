import 'dart:io';
import 'package:boggle/cleanser_certification.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class Detergent extends StatefulWidget {
  final String title;

  const Detergent({super.key, required this.title});

  @override
  State<Detergent> createState() => _DetergentState();
}

class _DetergentState extends State<Detergent> {
  File? _image;
  String scannedText = '';

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      getRecognizedText(pickedFile);
    }
  }

  void getRecognizedText(XFile image) async {
    try {
      // XFile 이미지를 InputImage 이미지로 변환
      final InputImage inputImage = InputImage.fromFilePath(image.path);

      // textRecognizer 초기화, 이때 script에 인식하고자하는 언어를 인자로 넘겨줌
      // ex) 영어는 script: TextRecognitionScript.latin, 한국어는 script: TextRecognitionScript.korean
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.korean);

      // 이미지의 텍스트 인식해서 recognizedText에 저장
      RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      print("Recognized text: ${recognizedText.text}");

      // 인식한 텍스트 정보를 scannedText에 저장
      scannedText = "";
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          scannedText = scannedText + line.text + "\n";
        }
      }

      print("Scanned text: $scannedText");

      setState(() {});

      // 리소스 해제
      await textRecognizer.close();

      // 인식한 텍스트를 다음 페이지로 전달
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Textcertification(
            recognizedText: scannedText,
          ),
        ),
      );
    } catch (e) {
      print("Error recognizing text: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, // 제목을 가운데 정렬
        title: const Text(
          '세제 인증',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0, // 그림자 제거
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const Text(
                '정확한 세제 인증을 위해 사진을 준비해 주세요.\n아래의 등록하기 버튼을 눌러 사진을 불러와주세요.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _image != null
                    ? Image.file(
                  _image!,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                )
                    : Image.asset(
                  'image/cleanserocr.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                ), // 기본 이미지를 표시
              ),
              const SizedBox(height: 35),
              const Text(
                '사진을 등록하면, 위의 그림과 같이 텍스트를 인식하여\n자동으로 세제의 이름이 입력됩니다.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color.fromARGB(255, 196, 42, 250),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '등록하기',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}