
import 'package:eco_process/views/login.dart';
import 'package:flutter/cupertino.dart';
import '../views/main_view.dart';
import '../views/post/post_main_view.dart';
import '../views/post/post_write_screen.dart';
import '../views/profile_view.dart';

class Routes {
  Routes._();

  static const String home = '/home';
  static const String app = '/app';
  static const String main = '/main';
  static const String page = '/page';
  static const String board = '/board';
  static const String write = '/write';
  static const String login = '/login';


  static final routes = <String, WidgetBuilder>{
    // home: (BuildContext context) => HomeScreen(),
    login: (BuildContext context) => SignInDemo(),

    main: (BuildContext context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return MainView(title: "메인");
    },
    board: (BuildContext context) {
      return PostMainView();
    },
    page: (BuildContext context) {
      return OpenContainerTransformDemo();
    },
    write: (BuildContext context) {
      return PostWriteScreen();
    },

  };
}