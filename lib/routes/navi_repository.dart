
import 'package:flutter/material.dart';

class NaviRepository {

  final GlobalKey<NavigatorState> mainKey = GlobalKey();
  final GlobalKey<NavigatorState> postKey = GlobalKey();
  final GlobalKey<NavigatorState> pageKey = GlobalKey();
  final GlobalKey<NavigatorState> sajooKey = GlobalKey();

  NaviRepository(){

    print('>>>> 네비레포지토리 생성자 호출 >>>>');
    print('>>>> 네비레포지토리 해쉬코드 >>>>' + this.hashCode.toString());
    print('>>>> 네비레포지토리 mainKey >>>>' + mainKey.currentState.toString());
  }

}