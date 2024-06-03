import 'package:boggle/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CertificationPage extends StatelessWidget{
  const CertificationPage({Key? key, required this.certification}) : super(key: key);

  final Certification certification;

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
          children: [
            Image.asset(certification.cleanserImage),
            Text(certification.cleansername),
            Text(certification.certificationdate)
          ],
        ),
      ),
    );
  }
}
