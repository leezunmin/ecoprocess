import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class FireStoreDB {
  late final FirebaseFirestore _firestore;
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FireStoreDB() {
    _firestore = FirebaseFirestore.instance;
  }

  Future addPost(Post post) async {
    DocumentReference documentRef = _firestore.collection('post').doc();

    try {
      // await _firestore.collection('post').doc("test")
      //     .set({
      //   'firebaseUid': post.m_id,
      // });
      await documentRef.set({
        'writer': post.writer,
        'title': post.title,
        'content': post.content,
        'isCreatedAt': DateTime.now().toString()
      });
    } catch (e) {
      print("Error : " + e.toString());
    }
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> fetchFirstPost(
      // String? requiredFilter,
      {String? filter,
      String? header,
      String? ownerId}) async {
    // requiredFilter = switchFilter(requiredFilter!);
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docsList;

    docsList = [];

    try {
      docsList = (await _firestore
              .collection("post")
              // .where('deleteFlag', isEqualTo: "N")
              //   .orderBy("isCreatedAt", descending: true)
              // .orderBy("sequence", descending: true)
              .limit(15)
              .get())
          .docs;
    } catch (e) {
      print('파베 데이터 가져오기 캐치 에러 11 ' + e.runtimeType.toString());
      print('파베 데이터 가져오기 캐치 에러 22 ' + e.toString());
    }

    return docsList;
  }
}
