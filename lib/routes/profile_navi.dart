

import 'package:eco_process/views/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileNavigator extends StatefulWidget {
  @override
  _ProfileNavigator createState() => _ProfileNavigator();
}

class _ProfileNavigator extends State<ProfileNavigator> {

  GlobalKey<NavigatorState> _userInfoNaviKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    print('프로필 네비게이터 빌드 >> ');
    return Navigator(
      key : _userInfoNaviKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              /*
              switch (settings.name) {
                case '/':
                  return Books1();
                case '/books2':
                  return Books2();
              }*/

              return ProfileView();
            });
      },
    );
  }
}
