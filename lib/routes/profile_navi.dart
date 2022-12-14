

import 'package:eco_process/views/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileNavigator extends StatefulWidget {
  @override
  _ProfileNavigator createState() => _ProfileNavigator();
}

class _ProfileNavigator extends State<ProfileNavigator> {

  GlobalKey<NavigatorState> _profileNavi = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key : _profileNavi,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return OpenContainerTransformDemo();
            });
      },
    );
  }
}
