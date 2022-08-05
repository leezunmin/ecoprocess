import 'dart:convert';
import 'package:darty_json/darty_json.dart';
// import 'package:acornbit_admin/common.dart';

import 'package:eco_process/repository/common.dart';

class Post {
  String writer;
  String title;
  String content;
  String isCreatedAt;


  Post({
    required this.writer,
    required this.title,
    required this.content,
    required this.isCreatedAt,

  });

  factory Post.fromMap(Map<String, dynamic> json) => Post(
    isCreatedAt: json['isCreatedAt'],
    content: json['content'],
    title: json['title'],
    writer: json['writer'],
  );

  Map<String, dynamic> toJson() {
    return {
      'writer': writer,
      'title': title,
      'content': content,
      'isCreatedAt': isCreatedAt,

    };
  }

  /*factory Post.fromJson(Map<String, dynamic> map) {
    final json = convertToJson(map);
    final rc = Post(
      m_id: json['m_id'].stringValue,
      // isCreatedAt: json['isCreatedAt'],
    );

    var index = 0;
    // while (true) {
    //   final key = "$index";
    //   if (json.exists(key)) {
    //     rc.list.add(Post.fromJson(json[key].mapObjectValue));
    //     index++;
    //   } else {
    //     break;
    //   }
    // }

    return rc;
  }*/
}
