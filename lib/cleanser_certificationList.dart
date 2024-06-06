import 'package:boggle/certification_page.dart';
import 'package:boggle/detergent_certification.dart';
import 'package:boggle/main.dart';
import 'package:boggle/mypage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: EdgeInsets.all(10.10),
          child: AppBar(
            title: const Text('세제 인증 내역',style: TextStyle(color: Colors.black),),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: certificationData.length,
          itemBuilder: (context, index){
            return Column(
              children: [
              Container(
                color: Colors.white,
                child: ListTile(
                  title: Text(
                  certificationData[index].cleansername,
                    style: GoogleFonts.notoSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        certificationData[index].certificationcheck,
                        style: GoogleFonts.notoSans(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 196, 42, 250),
                        )
                    ),
                      Align(
                        alignment: Alignment.centerRight,
                      child: Text(
                        certificationData[index].certificationdate,
                        style: GoogleFonts.notoSans(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 190, 190, 190),
                        ),
                       ),
                      ),
                  ],
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CertificationPage(certification: certificationData[index],)));
                  debugPrint(certificationData[index].cleansername);
                },
              ),
            ),
            const Divider(
              height: 1,
              color: Color.fromARGB(255, 190, 190, 190),
            ),
            ],
            );
          },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(20.0),
          child: FloatingActionButton(
        onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(
                builder: (context) => const Detergent(title: '',
                ),
            ));
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromARGB(255, 196, 42, 250),
      ),
      )
    );
  }
}
