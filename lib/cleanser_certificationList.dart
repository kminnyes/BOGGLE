import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model.dart';
import 'certification_page.dart';
import 'detergent_certification.dart';

class cleanserList extends StatelessWidget {
  final Certification? newCertification;

  const cleanserList({Key? key, this.newCertification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: cleanserCertificationList(newCertification: newCertification),
    );
  }
}

class cleanserCertificationList extends StatefulWidget {
  final Certification? newCertification;

  const cleanserCertificationList({Key? key, this.newCertification}) : super(key: key);

  @override
  State<cleanserCertificationList> createState() => _State();
}

class _State extends State<cleanserCertificationList> {
  List<Certification> certificationData = [
    Certification('살림인 100% 친환경 세제', '인증완료', '2024-05-01', File('image/sallimin.jpg')),
    Certification('슈가버블 친환경 세제', '인증완료', '2024-02-15', File('image/sugarbubble.jpg'))
  ];

  @override
  void initState() {
    super.initState();
    if (widget.newCertification != null) {
      certificationData.add(widget.newCertification!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.all(10.10),
          child: AppBar(
            title: const Text('세제 인증 내역', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: certificationData.length,
        itemBuilder: (context, index) {
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
                        color: const Color.fromARGB(255, 0, 0, 0),
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
                            color: const Color.fromARGB(255, 196, 42, 250),
                          )
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          certificationData[index].certificationdate,
                          style: GoogleFonts.notoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 190, 190, 190),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CertificationPage(certification: certificationData[index])));
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
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Detergent(title: '세제 인증'),
              ),
            );
            if (result != null && result is Certification) {
              setState(() {
                certificationData.add(result);
              });
            }
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 196, 42, 250),
        ),
      ),
    );
  }
}