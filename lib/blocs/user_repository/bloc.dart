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



import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_process/blocs/user_repository/state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'event.dart';

// part 'user_repository_event.dart';
// part 'user_repository_state.dart';

class UserRepositoryBloc
    extends Bloc<UserRepositoryEvent, UserRepositoryState> {

 /* final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ApiService _apiService = ApiService();
  final FireStoreDB _fireStoreDB = FireStoreDB();
  late FortuneLogic _fortuneLogic;*/


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final reportSub = BehaviorSubject<TextEditingController>();

  UserRepositoryBloc({initialState}) : super(InitialUserRepositoryState()) {
    debugPrint('블록 UserRepositoryBloc 생성>>>');


  }

  // 이벤트 핸들러
  EventTransformer<UserRepositoryEvent> distinctEvent<UserRepositoryEvent>() {
    return (events, mapper) => events.distinct().flatMap((mapper));
  }


}
