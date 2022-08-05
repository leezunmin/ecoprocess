import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


class ProfileView extends StatefulWidget {
  @override
  State createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {


  @override
  void initState() {
    super.initState();
    print('ProfileViewState initState ');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('금여록'),
          backgroundColor: Colors.white,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:  Container(
            height: 300,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  // 인용구
                    '사용자 정보 없음.',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                    )),
              ),
            ))

          // 원본
          // bodyWidget()

        ));
  }

  bodyWidget() {

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          return Text('하이');
        });
  }

  informWidget(String luckyTime) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            // height: constraints.maxHeight,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                // color: const Color(0xff646F7C),
                // border: Border.all(width: 0, color: Color.fromRGBO(58, 66, 86, .7)),
                  borderRadius: BorderRadius.circular(25.0)),

              // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .7)),
              child:
              Container(
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: CircleAvatar(
                                  backgroundImage:
                                  ExactAssetImage('assets/images/icon.png'))),

                          SizedBox(width: 10),
                          Text(
                            "작은 행운이 찾아올 수 있는 시간은 ?? ",
                            style: TextStyle(color: Colors.black87, fontSize: 12,),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black26,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Text(luckyTime,
                          style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                      SizedBox(
                        height: 11,
                      ),
                      Text("행운 지수가 좋은 경우, 이러한 시간대에 작은 행운이 찾아올 수 있습니다." +
                          "행운의 모습은 정해지지 않았습니다. 대체적으로 생각지 못한 문제의 해결, 소소한 행운, 누군가 나에게 도움을 준다든지 등의 일이 발생할 수 있습니다.",
                        style: TextStyle(color: Colors.grey[600],
                            overflow: TextOverflow.ellipsis, fontSize: 12),
                        maxLines: 6,
                      ),

                    ],

                  )

              ));
        });
  }

}
