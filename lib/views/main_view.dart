import 'package:eco_process/routes/post_navi.dart';
import 'package:eco_process/routes/profile_navi.dart';
import 'package:eco_process/routes/dummy_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

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
    _controller = TabController(length: 3, vsync: this); //vsync는 무조건 this
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screentHeight = MediaQuery.of(context).size.height;
    final screentWidth = MediaQuery.of(context).size.width;

    debugPrint('screentWidth >> ' + screentWidth.toString());

    return Container(
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
                print('onTap index >> ${index}');
                setState(() {
                  screenIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: "웹페이지 과제",
                  icon: Icon(Icons.announcement),
                ),
                BottomNavigationBarItem(
                  label: "게시판",
                  icon: Icon(Icons.library_books_outlined),
                ),
                BottomNavigationBarItem(
                  label: "Dummy",
                  icon: Icon(Icons.account_circle),
                ),
              ],
            ),
            body: WillPopScope(
              onWillPop: _onBackPressed,
              child: IndexedStack(
                index: screenIndex,
                children: <Widget>[
                  ProfileNavigator(),
                  PostNavigator(),
                  DummyNavigator(),
                ],
              ),
            )));
  }

  Future<bool> _onBackPressed() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("앱을 종료하시겠습니까?"),
        actions: <Widget>[
          FlatButton(
            child: Text("종료"),
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
