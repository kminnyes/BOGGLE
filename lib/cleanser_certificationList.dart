import 'package:boggle/certification_page.dart';
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
  static List<String> cleanserCheck = [' 인증완료', ' 인증완료'];
  static List<String> cleanserDate = ['2024-05-01', '2024-02-15'];
  static List<String> cleanserImage = ['image/sallimin.jpg', 'image/sugarbubble.jpg'];

  final List<Certification> certificationData = List.generate(cleanserName.length, (index) =>
      Certification(cleanserName[index], cleanserCheck[index], cleanserDate[index], cleanserImage[index])); // 생성자


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('세제 인증 내역'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: certificationData.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Text(
                  certificationData[index].cleansername,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                ),
                subtitle: Text(
                  certificationData[index].certificationcheck,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 196, 42, 250),
                  )
                ),
                /*leading: SizeBox(
                  height: 50,
                  width:50.
                  child : Image.asset(certificationData[index].(모델클래스의 이미지 정보)
                 */

                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CertificationPage(certification: certificationData[index],)));
                  debugPrint(certificationData[index].cleansername);
                },
              ),
            );
          },
      ),
    );
  }
}
