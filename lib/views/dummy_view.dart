import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DummyView extends StatefulWidget {
  const DummyView({super.key});

  @override
  State<DummyView> createState() => _DummyViewState();
}

class _DummyViewState extends State<DummyView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: const <Widget>[
        Expanded(
          child: Text('빈 페이지')
        ),
        
      ],
    );

  }

}
