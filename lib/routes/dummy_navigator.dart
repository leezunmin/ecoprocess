

import 'package:eco_process/views/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/dummy_view.dart';


class DummyNavigator extends StatefulWidget {
  @override
  _DummyNavigator createState() => _DummyNavigator();
}

class _DummyNavigator extends State<DummyNavigator> {

  GlobalKey<NavigatorState> _dummyNaviKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key : _dummyNaviKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return DummyView();
            });
      },
    );
  }
}
