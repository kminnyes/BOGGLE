import 'package:boggle/main.dart';
import 'package:boggle/mypage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';

void main(){
  runApp(const MyApp());
}

class cleanserList extends StatelessWidget{
  const cleanserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: cleanserCertificationList(),
    );
  }
}

class cleanserCertificationList extends StatefulWidget {
  const cleanserCertificationList({Key? key}) : super(key: key);

  @override
  State<cleanserCertificationList> createState() => _State();
}

class _State extends State<cleanserCertificationList> {

  static List<String> cleanserName = ['살림인 100% 친환경 세제', '슈가버블 친환경 세제']; // 추후에 DB에서 리스트값을 받아와야함.
  static List<String> cleanserCheck = ['살림인 100% 친환경 세제', '슈가버블 친환경 세제'];
  static List<String> cleanserDate = ['살림인 100% 친환경 세제', '슈가버블 친환경 세제'];

  final List<Certification> certificationData = List.generate(cleanserName.length, (index) =>
      Certification(cleanserName[index], cleanserCheck[index], cleanserDate[index])); // 생성자


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('세제 인증 내역'),
      ),
      body: ListView.builder(
          itemCount: certificationData.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Text(
                  certificationData[index].cleansername
                ),
                /*leading: SizeBox(
                  height: 50,
                  width:50.
                  child : Image.asset(certificationData[index].(모델클래스의 이미지 정보)
                 */
              ),
            );
          },
      ),
    );
  }
}
