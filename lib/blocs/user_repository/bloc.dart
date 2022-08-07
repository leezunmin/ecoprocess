// import 'package:bloc/bloc.dart';
//
// import 'event.dart';
// import 'state.dart';
//
// class UserRepositoryBloc extends Bloc<UserRepositoryEvent, UserRepositoryState> {
//   UserRepositoryBloc() : super(UserRepositoryState().init()) {
//     on<InitEvent>(_init);
//   }
//
//   void _init(InitEvent event, Emitter<UserRepositoryState> emit) async {
//     emit(state.clone());
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:get/get.dart';
import '../post_controller.dart';

part 'event.dart';
part 'state.dart';


class UserRepositoryBloc
    extends Bloc<UserRepositoryEvent, UserRepositoryState> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final reportSub = BehaviorSubject<TextEditingController>();
  String loginId = "비로그인";
  final _postController = Get.find<PostController>();
  late final GoogleSignInAccount? currentUser;
  late final GoogleSignIn? googleSignIn;

  UserRepositoryBloc({required UserRepositoryState initialState})
      : super(initialState) {
    debugPrint('블록 UserRepositoryBloc 생성>>>');

    on<Login>((event, emit) async {
      // final result = await getFetchFirst();

      print('로긴 정보 >> ' + event.currentUser!.email);
      _postController.isUsersId = event.currentUser!.email;

      currentUser = event.currentUser;
      googleSignIn = event.googleSignIn;

      emit(UserStatus(true,
          currentUser: event.currentUser, googleSignIn: event.googleSignIn));
    },
        transformer: distinctEvent()
        //  transformer: asyncExpandEvent()
    );

    on<LogOut>((event, emit) async {

      currentUser = null;
      await googleSignIn!.signOut();
      await googleSignIn!.disconnect();

      _postController.isUsersId = "none";
      emit(UserInitStatus());
    },
        transformer: distinctEvent()
    );


  }

  // 이벤트 distinct
  EventTransformer<UserRepositoryEvent> distinctEvent<UserRepositoryEvent>() {
    return (events, mapper) => events.distinct().flatMap((mapper));
  }

  // 이벤트 asyncExpand
  EventTransformer<UserRepositoryEvent> asyncExpandEvent<UserRepositoryEvent>() {
    return (events, mapper) => events.asyncExpand((mapper));
  }

  @override
  @mustCallSuper
  Future<void> close() async {
    return super.close();
  }
}
