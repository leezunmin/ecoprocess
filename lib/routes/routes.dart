
import 'package:eco_process/main.dart';
import 'package:eco_process/views/login.dart';
import 'package:flutter/cupertino.dart';

import '../views/main_view.dart';
import '../views/post/post_main_view.dart';
import '../views/post/post_write_screen.dart';

class Routes {
  Routes._();

  static const String home = '/home';
  static const String app = '/app';
  static const String detail = '/detail';
  static const String main = '/main';
  static const String board = '/board';
  static const String write = '/write';
  static const String login = '/login';



  static final routes = <String, WidgetBuilder>{
    // home: (BuildContext context) => HomeScreen(),
    app : (BuildContext context) => MyApp(),
    login: (BuildContext context) => SignInDemo(),

    // detail: (BuildContext context) {
    //   final args = ModalRoute.of(context)!.settings.arguments as String;
    //   return DetailPage(args);
    // },
    main: (BuildContext context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return MainView(title: "kkk");
    },
    board: (BuildContext context) {
      return PostMainView();
    },
    write: (BuildContext context) {
      // final args = ModalRoute.of(context)!.settings.arguments as String;
      return PostWriteScreen();
    },

  };
}