import 'dart:convert';
import 'package:darty_json/darty_json.dart';
// import 'package:acornbit_admin/common.dart';

import 'package:eco_process/repository/common.dart';

class Post {
  String writer;
  String title;
  String content;
  String isCreatedAt;
  String? uid;
  String deleteFlag;


  Post({
    required this.writer,
    required this.title,
    required this.content,
    required this.isCreatedAt,
    required this.deleteFlag,
    this.uid

  });

  factory Post.fromMap(Map<String, dynamic> json) => Post(
    isCreatedAt: json['isCreatedAt'],
    content: json['content'],
    title: json['title'],
    writer: json['writer'],
    uid: json['uid'],
    deleteFlag: json['deleteFlag'],
  );

  // Map<String, dynamic> toJson() {
  //   return {
  //     'writer': writer,
  //     'title': title,
  //     'content': content,
  //     'isCreatedAt': isCreatedAt,
  //     'uid': uid,
  //   };
  // }

  // Map<String, dynamic> toMap({ int? nodeId }) {
  //   final Map<String, dynamic> event = <String, dynamic>{
  //     'type': type,
  //     'data': getDataMap(),
  //   };
  //   if (nodeId != null)
  //     event['nodeId'] = nodeId;
  //
  //   return event;
  // }
}
