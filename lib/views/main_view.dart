import 'package:eco_process/routes/post_navi.dart';
import 'package:eco_process/routes/profile_navi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import '../routes/chat_navi.dart';

class MainView extends StatefulWidget {
  MainView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  int screenIndex = 0;
  late TabController _controller;
  late DateTime backbuttonpressedTime;

  @override
  void initState() {
    super.initState();
    // initPermission();

    _controller = TabController(length: 3, vsync: this); //vsync는 무조건 this
    print('메인 뷰');
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screentHeight = MediaQuery.of(context).size.height;
    final screentWidth = MediaQuery.of(context).size.height;

    debugPrint('screentWidth >> ' + screentWidth.toString());

    return Container(
        // width: screentWidth,
        child: Scaffold(
            // appBar: AppBar(
            //   title: Text('초기 앱 바'),
            // ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.lightBlueAccent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(.60),
              selectedFontSize: 14,
              unselectedFontSize: 14,
              currentIndex: screenIndex, //현재 선택된 Index
              onTap: (int index) {
                print('온탭 인덱스 >> ${index}');
                setState(() {
                  screenIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: "자기소개",
                  icon: Icon(Icons.announcement),
                ),
                BottomNavigationBarItem(
                  label: "게시판",
                  icon: Icon(Icons.library_books_outlined),
                ),
                BottomNavigationBarItem(
                  label: "추가기능",
                  icon: Icon(Icons.account_circle),
                ),
                // BottomNavigationBarItem(
                //   label: "세팅",
                //   icon: Icon(Icons.settings_applications),
                // ),
              ],
            ),
            body: WillPopScope(
              //  onWillPop: () async => false,
              onWillPop: _onBackPressed,
              // onWillPop: onWillPop,

              child: IndexedStack(
                index: screenIndex,
                children: <Widget>[
                  ProfileNavigator(),
                  PostNavigator(),
                  ChatNavigator(),
                  // TodayGraphNavigator(),
                  // SajooNavigator(),
                  // HoroscopeNavigator(),
                ],
              ),
            )));
  }

  Future<bool> onWillPop() async {
    print('온 윌 팝');
    final DateTime currentTime = DateTime.now();

    //Statement 1 Or statement2
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);

    if (backButton) {
      backbuttonpressedTime = currentTime;

      // ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('뒤로갈거냐.'),
      //   duration: Duration(seconds: 1),
      // ));

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("정말로 끝낼꺼야?"),
          actions: <Widget>[
            FlatButton(
              child: Text("그럴꺼야"),
              onPressed: () => Navigator.pop(context, true),
            ),
            FlatButton(
              child: Text("아뉘야"),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      );
    }
    return true;
    SystemNavigator.pop();
  }

  Future<bool> _onBackPressed() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("앱을 종료하시겠습니까?"),
        actions: <Widget>[
          FlatButton(
            child: Text("종료"),

            // onPressed: () => Navigator.pop(context, true),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          FlatButton(
            child: Text("아니오"),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );

    return true;
  }
}
