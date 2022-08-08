
import 'package:flutter/material.dart';

class NaviRepository {

  final GlobalKey<NavigatorState> mainKey = GlobalKey();
  final GlobalKey<NavigatorState> postKey = GlobalKey();
  final GlobalKey<NavigatorState> pageKey = GlobalKey();

  NaviRepository(){
    print('>>>> NaviRepository()  >>>>');
  }

}