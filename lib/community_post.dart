import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:boggle/communityInfo.dart';

class CommunityPostPage extends StatelessWidget{
  const CommunityPostPage({Key? key, required this.communityPost}) : super(key: key);

  final CommunityPost communityPost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 196, 42, 250)),
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(communityPost.userImage),
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 8.0),
                Text(communityPost.userNickname,
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.black
                        )),
                Spacer(),
                Text(communityPost.postdate,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black)),
              ],
            ),
            SizedBox(height: 16.0),
            Text(communityPost.postTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black)),
            SizedBox(height: 8.0),
            Text(communityPost.postContent,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black)),
            Divider(color: Colors.grey),
            Expanded(
              child: ListView(
                children: [
                  // Here you can add a list of comments
                  ListTile(
                    leading: Icon(Icons.comment),
                    title: Text(
                        '댓글 1 테스트',
                        style: TextStyle(
                            color: Colors.black)),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '댓글을 입력해주세요.',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Color.fromARGB(255, 196, 42, 250)),
                    onPressed: () {
                      // Handle send comment action
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}