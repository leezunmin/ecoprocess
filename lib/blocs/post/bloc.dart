import 'dart:async';
import 'dart:io';
// import 'package:application/models/models.dart';
// import 'package:application/repositories/repository.dart';
// import 'package:application/services/log_mixin.dart';
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
  final FireStoreDB repository;
  final _postController = Get.find<PostController>();

  PostBloc({
    required PostState initialState,
    required this.repository,
  }) : super(initialState) {
    on<Fetch>((event, emit) async {
      final result = await getFetchFirst();

      emit(Loaded(
        postList: result,
      ));
    }, transformer: distinctEvent());

    on<AddPostEvent>(
      (event, emit) async {
        print('애드포스트 이벤트');

        Post post = Post(
            writer: event.post.writer,
            title: event.post.title,
            content: event.post.content,
            isCreatedAt: DateTime.now().toString(),
            deleteFlag: "N");
        await repository.addPost(post);
        final result = await getFetchFirst();
        emit(Loaded(
          postList: result,
        ));
      },
      /// Apply the custom `EventTransformer` to the `EventHandler`.
      transformer: distinctEvent(),
    );
    on<RemovePostEvent>((event, emit) async {
      await repository.removePost(event.uid);
      final result = await getFetchFirst();

      emit(Loaded(
        postList: result,
      ));
    }, transformer: distinctEvent());
  }

  Future<List<Post>> getFetchFirst() async {
    List<Post> postList = [];

    try {
      documentList = await repository.fetchFirstPost();
      for (var element in documentList) {
        postList.add(Post.fromMap(element.data()!)!);
      }
      debugPrint('postList 출력 >> ' + postList.toString());
    } catch (e) {
      print('getFetchFirst e 1' + e.runtimeType.toString());
      print('getFetchFirst e 2' + e.toString());
      print('getFetchFirst 캐치 에러남');
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
