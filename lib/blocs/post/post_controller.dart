import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PostController extends GetxController {

  String device = "";
  late TextEditingController textEditingController;
  // bool isCategorySelected = false;
  bool isUserWritedText = false;
  final textInputSub = BehaviorSubject<bool>();

  PostController() {
    // 사용자 텍스트입력 여부 이벤트 구독, 동일이벤트 수신은 거르고 값이 다를때만 작동
    textInputSub.stream.distinct().listen((textInput) {
      textInput == true ? inputValidate(true) : inputValidate(false);
    });
  }

  void inputValidate(bool isValidated) {
    isUserWritedText = isValidated;
    update();
  }

  @override
  void onClose() {
    // debugPrint('PostController onClose()');
    textEditingController.dispose();
    textInputSub.close();
  }
}