import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:boggle/do_list.dart';
import 'package:boggle/mypage.dart';
import 'package:boggle/community.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  final String userId;

  const MyHomePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0; // 페이지 인덱스 0,1,2,3
  String _nickname = '';
  int _points = 0;
  int _rank = 0;
  String? _location; // 초기값을 null로 설정
  late String _userId = widget.userId; // userId 할당

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  void _fetchUserInfo() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/user_info/$_userId'));
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes)); // UTF-8 디코딩
      setState(() {
        _nickname = data['nickname'] ?? ''; // null 체크 및 기본값 설정
        _points = data['point'] ?? 0;
        _rank = data['rank'] ?? 0;
        _location = data['location'] ?? 'Unknown';
      });
    } else {
      // 에러 처리
      print('Failed to load user info');
    }
  }

  // 페이지 이동 함수
  void _navigateToPage(int index) {
    Widget nextPage;
    switch (index) {
      case 0:
        nextPage = MyHomePage(userId: widget.userId);
        break;
      case 1:
        nextPage = DoList(userId: widget.userId);
        break;
      case 2:
        nextPage = Community(userId: widget.userId);
        break;
      case 3:
        nextPage = MyPage(userId: widget.userId);
        break;
      default:
        nextPage = MyPage(userId: widget.userId);
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
          items: [
            BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: '실천', icon: Icon(Icons.volunteer_activism)),
            BottomNavigationBarItem(
                label: '커뮤니티', icon: Icon(Icons.mark_chat_unread)),
            BottomNavigationBarItem(
                label: 'MY', icon: Icon(Icons.account_circle)),
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
                Text(_location ?? 'Unknown'),
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
                    Text('10'),
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
              '$_nickname 님의 포인트',
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
                    '$_points P',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 196, 42, 250),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 192, 52, 243),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        '뽑기 바로 진행하러 가기',
                        style: TextStyle(color: Colors.white),
                      ),
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
            Text(
              '나의 포인트를 비교하고 분석해보세요',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end, // 그래프를 아래쪽에 정렬
              children: [
                _buildPointsColumn(
                    '1,136 P', Colors.grey, '전체 사용자 평균 포인트', 100),
                _buildPointsColumn('$_points P',
                    Color.fromARGB(255, 196, 42, 250), '나의 포인트', _points),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '나의 순위',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '나는 상위 몇 프로?',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            ),
            Text(
              '나의 포인트 순위를 알려드립니다.',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 300, // 크기를 더 크게 설정
                    height: 300, // 크기를 더 크게 설정
                    child: Stack(
                      children: [
                        Center(
                            child: Container(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(
                            value: 0.7,
                            strokeWidth: 10, // 원의 두께를 더 두껍게 설정
                            color: Color.fromARGB(255, 196, 42, 250),
                            backgroundColor: Colors.grey[200],
                          ),
                        )),
                        Center(
                          child: Text(
                            '상위 70%',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 196, 42, 250),
                            ),
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
                        '$_nickname 님은 $_rank등 입니다.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
      String points, Color color, String label, int height) {
    return Column(
      children: [
        Text(
          points,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 50,
          height: height.toDouble(),
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
              Icons.water_drop, Colors.blue, '매우 좋음', '간단한 정수 후 마실 수 있음'),
          SizedBox(height: 10),
          _buildWaterQualityRow(
              Icons.water_drop, Colors.lightBlue, '좋음', '일반 정수 처리 후 마실 수 있음'),
          SizedBox(height: 10),
          _buildWaterQualityRow(Icons.water_drop,
              Color.fromARGB(255, 34, 192, 81), '약간 좋음', '일반 정수 처리 후 마실 수 있음'),
          SizedBox(height: 10),
          _buildWaterQualityRow(Icons.water_drop,
              Color.fromARGB(255, 148, 147, 147), '보통', '일반 정수 후 공업용수로 사용 가능'),
          SizedBox(height: 10),
          _buildWaterQualityRow(Icons.water_drop,
              Color.fromARGB(255, 125, 115, 28), '약간 나쁨', '농업용수로 사용 가능'),
          SizedBox(height: 10),
          _buildWaterQualityRow(
              Icons.water_drop, Colors.orange, '나쁨', '특수처리 후 공업용수로 사용 가능'),
          SizedBox(height: 10),
          _buildWaterQualityRow(
              Icons.water_drop, Colors.red, '매우 나쁨', '이용 불가능'),
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
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
