import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// class ChatView extends StatefulWidget {
//   @override
//   State createState() => ChatViewState();
// }

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return  Column(
      children: const <Widget>[
        Expanded(
          child: Text('ㅁㄴㅇㄹ')
        ),
        
      ],
    );

  }

}
