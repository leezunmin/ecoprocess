
import 'package:eco_process/views/post/post_main_view.dart';
import 'package:eco_process/views/chat_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navi_repository.dart';


class ChatNavigator extends StatefulWidget {
  @override
  _ChatNavigator createState() => _ChatNavigator();
}

class _ChatNavigator extends State<ChatNavigator> {

  GlobalKey<NavigatorState> _chatNaviKey = GlobalKey<NavigatorState>();

  late final NavigatorState _rootNavi;

  @override
  Widget build(BuildContext context) {
    print('채팅 네비게이터 빌드 >> ');

    return Navigator(
      key : _chatNaviKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {

              return ChatView();
            });
      },
    );

    // return PostMainView();
  }
}
