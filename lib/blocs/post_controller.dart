import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PostController extends GetxController {

  // bool isCategorySelected = false;
  bool isUserWritedText = false;
  // final textInputSub = BehaviorSubject<bool>();
  bool isOwnerValidated = false;
  String isUsersId = "none";
  final titleInputSub = BehaviorSubject<bool>.seeded(false);
  final contentInputSub = BehaviorSubject<bool>.seeded(false);
  late final validateSub = CombineLatestStream.combine2(
      titleInputSub.stream, contentInputSub.stream, (bool a, bool b) {
        // debugPrint('a >  ' + a.toString());
        // debugPrint('b > ' + b.toString());
    // if(b==true) {
    //   return true;
    // }else if(b==false){
    //   return false;
    // }

    if(a == true && b == true) {
      return true;
    }
  }).asBroadcastStream();

  PostController() {
    // 사용자 텍스트입력 여부 이벤트 구독, 동일이벤트 수신은 거르고 값이 다를때만 작동
    validateSub.distinct().listen((event) {
      print('이벤트 리슨' + event.toString());
      event == true ? inputValidate(true) : inputValidate(false);
    });
  }

  void inputValidate(bool isValidated) {
    isUserWritedText = isValidated;
    update();
  }

  // void postOwnerValidate(bool isValidated) {
  //   isOwnerValidated = isValidated;
  //   update();
  // }

  @override
  void onClose() {
    // debugPrint('PostController onClose()');
    // textInputSub.close();
    titleInputSub.close();
    contentInputSub.close();

  }
}
