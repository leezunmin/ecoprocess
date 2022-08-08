
import 'package:eco_process/views/post/post_main_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navi_repository.dart';


class PostNavigator extends StatefulWidget {
  @override
  _PostNavigator createState() => _PostNavigator();
}

class _PostNavigator extends State<PostNavigator> {

  GlobalKey<NavigatorState> _userInfoNaviKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    print('포스트 네비게이터 빌드 >> ');

    return Navigator(
      key : _userInfoNaviKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {

              return PostMainView();
            });
      },
    );
  }
}
