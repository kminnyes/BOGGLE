import 'package:flutter/material.dart';

class CommunityPost{
  final String userNickname;// 작성자 닉네임
  final String userImage; // 작성자 개인 이미지
  final String postdate; // 작성 날짜
  final String postTitle; // 작성된 제목
  final String postContent;// 작성된 내용

  CommunityPost(this.userNickname, this.userImage, this.postdate, this.postTitle, this.postContent);
}