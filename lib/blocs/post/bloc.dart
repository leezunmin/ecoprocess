import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import '../../models/post.dart';
import '../../repository/firestore.dart';
import 'package:get/get.dart';
import '../post_controller.dart';
part 'event.dart';
part 'state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  late List<DocumentSnapshot<Map<String, dynamic>>> documentList;
  final FireStoreDB fireStoreDB;
  final _postController = Get.find<PostController>();

  PostBloc({
    required PostState initialState,
    required this.fireStoreDB,
  }) : super(initialState) {
    on<Fetch>((event, emit) async {
      final result = await doFetchPost();

      emit(Loaded(
        postList: result,
      ));
    }, transformer: distinctEvent());

    on<AddPostEvent>(
      (event, emit) async {
        debugPrint('>>> AddPostEvent');
        final Post post = Post(
            writer: event.writer,
            title: event.title,
            content: event.content,
            isCreatedAt: event.isCreatedAt,
            deleteFlag: "N");

        await fireStoreDB.addPost(post);
        final result = await doFetchPost();
        emit(Loaded(postList: result));
      },

      /// Apply the custom `EventTransformer` to the `EventHandler`.
      transformer: distinctEvent(),
    );
    on<RemovePostEvent>((event, emit) async {
      await fireStoreDB.removePost(event.uid);
      final result = await doFetchPost();

      emit(Loaded(postList: result));
    }, transformer: distinctEvent());
  }

  Future<List<Post>> doFetchPost() async {
    List<Post> postList = [];

    try {
      documentList = await fireStoreDB.doFetchPost();
      for (var element in documentList) {
        postList.add(Post.fromMap(element.data()!)!);
      }
      debugPrint('postList 출력 >> ' + postList.toString());
    } catch (e) {
      print('ErrorType : ' + e.runtimeType.toString());
      print('error' + e.toString());
    }
    return postList;
  }

  // 이벤트 핸들러, 중복 이벤트 처리
  EventTransformer<PostEvent> distinctEvent<PostEvent>() {
    return (events, mapper) => events.distinct().flatMap((mapper));
  }

  @override
  @mustCallSuper
  Future<void> close() async {
    return super.close();
  }
}
