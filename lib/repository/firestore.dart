import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class FireStoreDB {
  late final FirebaseFirestore _firestore;

  FireStoreDB() {
    _firestore = FirebaseFirestore.instance;
  }

  Future addPost(Post post) async {
    DocumentReference documentRef = _firestore.collection('post').doc();

    try {
      await documentRef.set({
        'writer': post.writer,
        'title': post.title,
        'content': post.content,
        'isCreatedAt': DateTime.now().toString(),
        'uid': documentRef.id,
        'deleteFlag': "N"
      });
    } catch (e) {
      print("Error : " + e.toString());
    }
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> doFetchPost() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docsList;
    docsList = [];

    try {
      docsList = (await _firestore
              .collection("post")
              .where('deleteFlag', isEqualTo: "N")
              .orderBy("isCreatedAt", descending: true)
              // .limit(15)
              .get())
          .docs;
    } catch (e) {
      print('ErrorType : ' + e.runtimeType.toString());
      print('e ' + e.toString());
    }
    return docsList;
  }

  Future removePost(String postUid) async {
    try {
      _firestore.collection('post').doc(postUid).update({"deleteFlag": "Y"});
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
