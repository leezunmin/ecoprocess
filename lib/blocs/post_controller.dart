import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PostController extends GetxController {

  String device = "";
  late TextEditingController textEditingController;
  // bool isCategorySelected = false;
  bool isUserWritedText = false;
  final textInputSub = BehaviorSubject<bool>();
  bool isOwnerValidated = false;
  String isUsersId = "none";

  PostController() {
    // 사용자 텍스트입력 여부 이벤트 구독, 동일이벤트 수신은 거르고 값이 다를때만 작동
    textInputSub.stream.distinct().listen((textInput) {
      textInput == true ? inputValidate(true) : inputValidate(false);
    });

    // CombineLatestStream.combine2(list, accountType,
    //         (List<Account> accounts, String accountType, String currency) {
    //       // pageCon.goToFirstPage();   // 무한 리스트뷰를 위해 주석처리
    //
    //       return accounts.where((e) {
    //         return (accountType == "" || e.real_demo == accountType) &&
    //             (currency == "" || e.m_currency == currency);
    //       }).toList();
    //     })
  }

  void inputValidate(bool isValidated) {
    isUserWritedText = isValidated;
    update();
  }

  void postOwnerValidate(bool isValidated) {
    isOwnerValidated = isValidated;
    update();
  }

  @override
  void onClose() {
    // debugPrint('PostController onClose()');
    textEditingController.dispose();
    textInputSub.close();
  }
}