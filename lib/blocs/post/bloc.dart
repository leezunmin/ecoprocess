import 'dart:async';
import 'dart:io';
// import 'package:application/models/models.dart';
// import 'package:application/repositories/repository.dart';
// import 'package:application/services/log_mixin.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_process/blocs/post/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import '../../models/post.dart';
import '../../repository/firestore.dart';
import 'package:get/get.dart';
part 'event.dart';
part 'state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  // final Repository repository;
  late List<DocumentSnapshot<Map<String, dynamic>>> documentList;
  // late List<AppVoteItem>? voteList;
  final postBlocTitleSub = BehaviorSubject<TextEditingController>();
  final postBlocContentSub = BehaviorSubject<TextEditingController>();
  final FireStoreDB repository;

  final textInputSub = BehaviorSubject<bool>();
  bool isUserWritedText = false;
  final _postController = Get.find<PostController>();

  PostBloc({
    required PostState initialState,
    required this.repository,
    // this.voteList
  }) : super(initialState) {
    // 커뮤니티 게시글 가장 최신 첫번째 페이징값 가져오기 이벤트

    textInputSub.stream.distinct().listen((textInput) {
      print('텍스트 관찰 작동');
      print('텍스트 인풋 값 >> ' + textInput.toString());
      // textInput == true ? inputValidate(true) : inputValidate(false);
      textInput == true
          ? _postController.inputValidate(true)
          : _postController.inputValidate(false);
    });

    on<Fetch>((event, emit) async {
      final result = await getFetchFirst();

      emit(Loaded(
        postList: result,
        // currentHeader: initHeader,
        // currentSort: initSort,
        // 블록 이벤트로 넘어오기 이전에 텍스트 검증하고 오기때문에 isValidated true 이고 블록리스너로 라우팅
        isValidated: true,
        // isIncludeVote: event.voteList != null ? true : false
      ));
    }, transformer: distinctEvent());

    on<AddPostEvent>(
      (event, emit) async {
        print('애드포스트 이벤트');

        Post post = Post(
            writer: event.post.writer,
            title: event.post.title,
            content: event.post.content,
            isCreatedAt: DateTime.now().toString());
        await repository.addPost(post);

        final result = await getFetchFirst();

        emit(Loaded(
          postList: result,
          isValidated: true,
        ));
      },

      /// Apply the custom `EventTransformer` to the `EventHandler`.
      transformer: distinctEvent(),
    );
  }

  // 맨 첫번째 페이징값 가져오기 쿼리
  Future<List<Post>> getFetchFirst({String? filter, String? header}) async {
    List<Post> postList = [];

    try {
      documentList = await repository.fetchFirstPost();
      print('도큐먼트 리스트' + documentList.toString());

      for (var element in documentList) {
        postList.add(Post.fromMap(element.data()!)!);
      }
      print('postList 출력 >> ' + postList.toString());
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
    // return (events, mapper) => events.distinctUnique().flatMap((mapper));
  }

  void inputValidate(bool isValidated) {
    isUserWritedText = isValidated;
  }

  @override
  @mustCallSuper
  Future<void> close() async {
    return super.close();
  }
}
