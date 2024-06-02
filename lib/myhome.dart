import 'package:flutter/material.dart';
import 'package:boggle/do_list.dart';
import 'package:boggle/mypage.dart';
import 'package:boggle/community.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0; // 페이지 인덱스 0,1,2,3

  // 페이지 이동 함수
  void _navigateToPage(int index) {
    Widget nextPage;
    switch (index) {
      case 0:
        nextPage = MyHomePage();
        break;
      case 1:
        nextPage = DoList();
        break;
      case 2:
        nextPage = Community();
        break;
      case 3:
        nextPage = MyPage();
        break;
      default:
        nextPage = MyPage();
    }
    if (ModalRoute.of(context)?.settings.name !=
        nextPage.runtimeType.toString()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => nextPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = GoogleFonts.londrinaSolid(
      fontSize: 27,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(255, 196, 42, 250),
    );

    final TextStyle indicatorTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    return DefaultTabController(
      length: 2, // 상단 탭의 수
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text('BOGGLE', style: titleStyle),
              Text(
                '.',
                style: TextStyle(
                    color: Color.fromARGB(255, 196, 42, 250),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          centerTitle: false,
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true, // 탭이 스크롤 가능하게 설정
            tabs: [
              Tab(text: '어항'),
              Tab(text: '포인트'),
            ],
            indicatorColor: Color.fromARGB(255, 196, 42, 250), // 인디케이터 색상
            labelColor: Color.fromARGB(255, 196, 42, 250), // 선택된 탭의 색상
            unselectedLabelColor: Colors.black, // 선택되지 않은 탭의 색상
          ),
        ),
        body: TabBarView(
          children: [
            _buildAquariumTab(indicatorTextStyle),
            _buildPointsTab(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _index = index;
            });
            _navigateToPage(index);
          },
          currentIndex: _index,
          selectedItemColor: Color.fromARGB(255, 196, 42, 250),
          unselectedItemColor: Color.fromARGB(255, 235, 181, 253),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: '실천', icon: Icon(Icons.check_circle)),
            BottomNavigationBarItem(label: '커뮤니티', icon: Icon(Icons.group)),
            BottomNavigationBarItem(label: 'MY', icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }

  Widget _buildAquariumTab(TextStyle indicatorTextStyle) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue,
            height: 200,
            child: Center(
              child: Text(
                '어항 이미지',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('이달의 수질', style: indicatorTextStyle),
                DropdownButton<String>(
                  value: '북대동',
                  items: <String>['북대동', '남대동'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1.1 ppm',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  children: List.generate(10, (index) {
                    return Expanded(
                      child: Container(
                        height: 8,
                        color: _getColorForIndex(index),
                      ),
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1'),
                    Text('2'),
                    Text('3'),
                    Text('5'),
                    Text('8'),
                    Text('10<'),
                  ],
                ),
              ],
            ),
          ),
          _buildWaterQualityInfo(),
        ],
      ),
    );
  }

  Widget _buildPointsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '홍길동 님의 포인트',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 248, 248, 248),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '655 P',
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 196, 42, 250)),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 8, 8, 8), // 배경 색상
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      '뽑기 바로 진행하러 가기',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              '포인트 리포트',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPointsColumn(
                    '1,136 P', Colors.grey, '전체 사용자 평균 포인트', 100),
                _buildPointsColumn(
                    '655 P', Color.fromARGB(255, 196, 42, 250), '나의 포인트', 60),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '나의 순위',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: 0.7,
                              strokeWidth: 20,
                              color: Color.fromARGB(255, 196, 42, 250),
                              backgroundColor: Colors.grey[200],
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '상위 70%',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 196, 42, 250)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events, color: Colors.amber, size: 32),
                      SizedBox(width: 10),
                      Text(
                        '홍길동 님은 6950등 입니다.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsColumn(
      String points, Color color, String label, double height) {
    return Column(
      children: [
        Text(
          points,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: color),
        ),
        SizedBox(height: 10),
        Container(
          width: 50,
          height: height,
          color: color,
        ),
        SizedBox(height: 10),
        Text(label),
      ],
    );
  }

  Widget _buildWaterQualityInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '수질 등급',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildWaterQualityRow(
              Icons.water, Colors.blue, '매우 좋음', '간단한 정수 후 마실 수 있음'),
          SizedBox(height: 10),
          _buildWaterQualityRow(
              Icons.water, Colors.lightBlue, '좋음', '일반 정수 처리 후 마실 수 있음'),
        ],
      ),
    );
  }

  Widget _buildWaterQualityRow(
      IconData icon, Color color, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
        SizedBox(width: 8),
        Text(subtitle),
      ],
    );
  }

  Color _getColorForIndex(int index) {
    if (index < 2) return Colors.blue;
    if (index < 3) return Colors.lightBlue;
    if (index < 5) return Colors.green;
    if (index < 8) return Colors.orange;
    return Colors.red;
  }
}
