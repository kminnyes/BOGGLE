import 'package:boggle/sewer_report.dart';
import 'package:flutter/material.dart';

class Sewer extends StatelessWidget {
  const Sewer({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          'BOGGLE',
          style: TextStyle(color: Color.fromARGB(255, 147, 159, 248)),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RainGutterWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RainGutterWidget extends StatelessWidget {
  const RainGutterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Container(
  margin: const EdgeInsets.all(8.0),
  child: const SizedBox(
    width: 340,
    height: 30,
    child: Padding(
      padding: EdgeInsets.only(left: 0.0), // 왼쪽 패딩만 추가합니다.
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '빗물받이란?',
              style: TextStyle(
                color: Color(0xFF4F4F4F),
                fontSize: 20,
                fontFamily: 'Manrope',
                height: 0,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),

        Container(
   
        margin: const EdgeInsets.all(10.0),
          width: 340,
          height: 169,
          decoration: ShapeDecoration(
            image: const DecorationImage(
              image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY8RCmu3H6vCucl66nNTJiBq2wVJuqm-kGzQ&s"),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
        ),
        const SizedBox(
          width: 340,
          height: 70,
          child: Text(
            '빗물받이는 도로의 측구, 택지 기타에서 흘러오는빗물을 모아 취하수관으로 내보내는 받이를 말합니다.',
            style: TextStyle(
              color: Color(0xFF4F4F4F),
              fontSize: 15,
              fontFamily: 'Manrope',
              height: 0,
            ),
          ),
        ),
        const SizedBox(
          width: 340,
          height: 40,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '빗물받이가 막히면?',
                  style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontSize: 20,
                    fontFamily: 'Manrope',
                    height: 0,
                  ),
                ),
              
            
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 340,
          height: 50,
          child: Text(
            '💧 빗물받이가 막히면 빗물이 빠져나가지 못해 심각한 침수피해가 발생할 수 있습니다.',
            style: TextStyle(
              color: Color(0xFF4F4F4F),
              fontSize: 15,
              fontFamily: 'Manrope',
              height: 0,
            ),
          ),
        ),
       
  
       

const SizedBox(
  width: 340,
  height: 50,
  child: Text(
    '💧막힌 빗물받이는 각 시청, 군청 홈페이지에서 접수를 통해 해결할 수 있습니다.',
    style: TextStyle(
      color: Color(0xFF4F4F4F),
      fontSize: 15,
      fontFamily: 'Manrope',
      height: 0,
    ),
  ),
),



const SizedBox(
  width: 340,
  height: 70,
  child: Text(
    '💧막힌 빗물받이는 각 시청, 군청 홈페이지에서 접수를 통해 해결할 수 있습니다.',
    style: TextStyle(
      color: Color(0xFF4F4F4F),
      fontSize: 15,
      fontFamily: 'Manrope',
      height: 0,
    ),
  ),
),

GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SewerReport(title: '빗물받이 불편신고 접수하러 가기'),
      ),
    );
  },
  child: Container(
    width: 335,
    height: 70,
    decoration: ShapeDecoration(
      color: const Color(0xFFC42AFA),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: const Center(
      child: Text(
        '빗물받이 불편신고 접수하러 가기',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Manrope',
          height: 0,
        ),
      ),
    ),
  ),
),


                
              
            ],
          
        
      
    );
  }
}