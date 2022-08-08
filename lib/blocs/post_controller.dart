import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PostController extends GetxController {

  bool isUserWritedText = false;
  // bool isOwnerValidated = false;
  String isUsersId = "none";
  final titleInputSub = BehaviorSubject<bool>.seeded(false);
  final contentInputSub = BehaviorSubject<bool>.seeded(false);
  // 사용자 제목, 내용 입력 stream 결합 관찰
  late final validateSub = CombineLatestStream.combine2(
      titleInputSub.stream, contentInputSub.stream, (bool a, bool b) {
        print('제목 validate ' + a.toString());
        print('내용 validate ' + b.toString());

    if(a == true && b == true) {
      return true;
    }
  }).asBroadcastStream();

  PostController() {
    // 사용자 텍스트입력 여부 이벤트 구독, 동일이벤트 수신은 거르고 값이 다를때만 작동
    validateSub.distinct().listen((event) {
      debugPrint('validateSub.distinct().listen event >>' + event.toString());
      event == true ? inputValidate(true) : inputValidate(false);
    });
  }

  void inputValidate(bool isValidated) {
    isUserWritedText = isValidated;
    update();
  }


  @override
  void onClose() {
    debugPrint('포스트 컨트롤러 onClose');
    titleInputSub.close();
    contentInputSub.close();
  }
}
