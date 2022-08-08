
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/post/bloc.dart';
import '../../blocs/post_controller.dart';
import '../../models/post.dart';
import '../../style/colors.dart';
import '../../style/tokens.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';


class PostReadScreen extends StatefulWidget {
  static const routeName = '/read';
  final Post post;

  const PostReadScreen(this.post) : super();

  @override
  _PostReadScreenState createState() => _PostReadScreenState(post);
}

class _PostReadScreenState extends State<PostReadScreen> {
  _PostReadScreenState(this.post);
  final Post post;
  late final PostBloc _getPostBloc;

  @override
  void initState() {
    super.initState();

    _getPostBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                // 뒤로가기
                Navigator.of(context).pop();
              }),
          title: Text("게시글 읽기"),
          actions: [
            GetBuilder<PostController>(builder: (_) {
              return Container(
                  // margin: EdgeInsets.only(top: 14, bottom: 14, right: 20),
                  margin: EdgeInsets.only(top: 6, bottom: 6, right: 6),
                  // padding: EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () async {
                        if (_.isUsersId == post.writer) {
                          _getPostBloc.add(RemovePostEvent(uid: post.uid!));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('삭제되었습니다.'),
                            duration: Duration(seconds: 1),
                          ));
                          Navigator.of(context).pushNamed('/board');
                        }else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('본인 글만 삭제가능합니다.'),
                            duration: Duration(seconds: 1),
                          ));
                        }
                      },
                      child: _.isUsersId == post.writer
                    ? AutoSizeText(
                    '삭제',
                    style: TextStyle(fontSize: 20, color: AppColors.white),
                    maxLines: 1,
                  )
                          :
                      AutoSizeText(
                        '삭제',
                        style: TextStyle(fontSize: 20, color: AppColors.black12),
                        maxLines: 1,
                      )
                  ));
            })
          ],
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) {
            return SingleChildScrollView(
                child: SafeArea(
                    child: SizedBox(
              width: boxConstraints.maxWidth,
              child: Column(
                children: [
                  AppSpacers.height24,

                  AppSpacers.height8,
                  Container(
                      padding: AppEdgeInsets.horizontal16,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          post.title!,
                          // style: titleStyle,
                        ),
                      )),
                  AppSpacers.height8,
                  // _info(),
                  Padding(
                    padding: AppEdgeInsets.horizontal16,
                    child: Divider(
                      height: 32,
                      thickness: 1,
                    ),
                  ),
                  AppSpacers.height8,
                  Container(
                      padding: AppEdgeInsets.horizontal16,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          post.content,
                          maxLines: null,
                          textAlign: TextAlign.justify,
                          // style: contentStyle,
                        ),
                      )),
                  AppSpacers.height24,

                  AppSpacers.height24,
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),

                  Container(
                    color: AppColors.border,
                    height: 6,
                  ),
                  AppSpacers.height16,
                ],
              ),
            )));
          },
        ));
  }
}
