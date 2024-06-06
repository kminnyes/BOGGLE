import 'package:flutter/material.dart';
import 'package:boggle/do_list.dart';
import 'package:boggle/myhome.dart';
import 'package:boggle/mypage.dart';
import 'package:boggle/communityInfo.dart'; // Assuming this is the correct path for the detail screen
import 'package:google_fonts/google_fonts.dart';



class Community extends StatefulWidget {
  final String userId;

  const Community({Key? key, required this.userId}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  var _index = 2; // 페이지 인덱스 0,1,2,3

  // Generate sample data directly in community.dart
  final List<CommunityPost> posts = [
    CommunityPost(
      '홍길동',
      'assets/user1.png',
      '2024-05-01 13:17',
      '설거지 바 써보신분?',
      '제가 액체 주방세제에서 고체 주방세제로 바꾸려고 하는데 괜찮은 설거지 바 있으면 추천 부탁드립니다.',
    ),
    CommunityPost(
      '김철수',
      'assets/user2.png',
      '2024-05-01 13:06',
      '주말에 플로깅 가시는 분 있나요?',
      '이번주 무심천에서 진행하는 플로깅에 참여하고 싶은데 혹시 가시는 분 있나요?',
    ),
  ];

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
        nextPage = MyHomePage(userId: widget.userId);
    }
    if (ModalRoute.of(context)?.settings.name != nextPage.toString()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => nextPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          'BOGGLE',
          style: GoogleFonts.londrinaSolid(
            fontSize: 27,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 196, 42, 250),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ACTIVE',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text('금주의 플로깅에 참여해보세요!'),
                SizedBox(height: 16.0),
                Image.asset('image/commu.png'), // Updated image path
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommunityPostScreen(post: posts[index]),
                      ),
                    );
                  },
                  child: _buildPost(posts[index]),
                );
              },
            ),
          ),
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
          BottomNavigationBarItem(label: '실천', icon: Icon(Icons.check_circle)),
          BottomNavigationBarItem(label: '커뮤니티', icon: Icon(Icons.group)),
          BottomNavigationBarItem(label: 'MY', icon: Icon(Icons.person)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new post
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromARGB(255, 196, 42, 250),
      ),
    );
  }

  Widget _buildPost(CommunityPost post) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(post.userImage),
                backgroundColor: Colors.grey,
              ),
              SizedBox(width: 8.0),
              Text(post.userNickname),
              Spacer(),
              Text(post.postdate),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.postTitle, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4.0),
          Text(post.postContent),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.favorite),
                color: Colors.grey,
                onPressed: () {
                  // Handle like action
                },
              ),
              Text('15'), // Static example, replace with dynamic data
              SizedBox(width: 16.0),
              IconButton(
                icon: Icon(Icons.comment),
                color: Colors.grey,
                onPressed: () {
                  // Handle comment action
                },
              ),
              Text('1'), // Static example, replace with dynamic data
            ],
          ),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}

class CommunityPostScreen extends StatelessWidget {
  final CommunityPost post;

  CommunityPostScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          post.userNickname,
          style: TextStyle(
            color: Color.fromARGB(255, 196, 42, 250),
          ),
        ),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 196, 42, 250)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(post.userImage),
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 8.0),
                Text(post.userNickname),
                Spacer(),
                Text(post.postdate),
              ],
            ),
            SizedBox(height: 16.0),
            Text(post.postTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 8.0),
            Text(post.postContent, style: TextStyle(fontSize: 18)),
            Divider(color: Colors.grey),
            Expanded(
              child: ListView(
                children: [
                  // Placeholder for comments
                  Text('Comment Section Placeholder')
                ],
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle send comment
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
