import 'package:boggle/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CertificationPage extends StatelessWidget{
  const CertificationPage({Key? key, required this.certification}) : super(key: key);

  final Certification certification;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
    ' BOGGLE',
    style: GoogleFonts.londrinaSolid(
     fontSize:27,
     fontWeight: FontWeight.normal,
     color: Color.fromARGB(255, 196, 42, 250))),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //가운데 정렬
          children: [
            SizedBox(
              height: 350,
              width: 350,
              child: Image.asset(certification.cleanserImage),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(certification.cleansername,
            style: GoogleFonts.ibmPlexSansKr(
              fontSize: 23,
              fontWeight: FontWeight.bold
            ),
            ),
            const SizedBox(
              height: 10,
            ),

            Text('인증확인 일자 : ' + certification.certificationdate,
                style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal
            ),
            ),
          ],
        ),
      ),
    );
  }
}
