// import 'package:application/blocs/bloc_interface.dart';
// import 'package:application/blocs/blocs.dart';
// import 'package:application/blocs/validate_mixin.dart';
// import 'package:application/generated/assets.gen.dart';
// import 'package:application/models/enums/models.dart';
// import 'package:application/services/auth/auth_state_service.dart';
// import 'package:application/services/services.dart';
// import 'package:application/styles/styles.dart';
// import 'package:application/views/views.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../blocs/post/bloc.dart';
import '../../blocs/post_controller.dart';
import '../../models/post.dart';
import '../../routes/navi_repository.dart';
import '../../style/colors.dart';
import '../../style/tokens.dart';
import 'package:get/get.dart';

class PostReadScreen extends StatefulWidget {
  static const routeName = '/read';
  final Post post;

  const PostReadScreen(this.post) : super();

  @override
  _PostReadScreenState createState() => _PostReadScreenState(post);
}

class _PostReadScreenState extends State<PostReadScreen> {
  _PostReadScreenState(this.post);

  late Post post;
  late final NavigatorState _rootNavi;
  final bool voteAdded = false;
  // AppPostHeaderEnum _currentHeader = AppPostHeaderEnum.unknown;

  late final PostBloc _getPostBloc;
  /*late final ImageBloc _imgBloc;
  late final VoteBloc _voteBloc;*/

  final imgProgress = BehaviorSubject<bool>();

  @override
  void initState() {
    super.initState();

    // _rootNavi = context.read<NavigationService>().rootKey.currentState!;

    _rootNavi = context.read<NaviRepository>().mainKey.currentState!;

    _getPostBloc = BlocProvider.of<PostBloc>(context);
    // _getBloc.postBlocTitleSub.sink.add(titleEditingController!);
    // _getBloc.postBlocContentSub.sink.add(contentEditingController!);

    imgProgress.sink.add(false);
  }

  @override
  void dispose() {
    imgProgress.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('포스트 값 >> ' + post.title);
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
                  margin: EdgeInsets.only(top: 14, bottom: 14, right: 20),
                  padding: EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () async {
                        if (_.isUsersId == post.writer) {
                          _getPostBloc.add(RemovePostEvent(uid: post.uid!));
                          Navigator.of(context).pushNamed('/board');
                        }
                      },
                      child: _.isUsersId == post.writer
                          ? Text("삭제",
                              style: theme.textTheme.subtitle1!
                                  .copyWith(color: AppColors.white))
                          : Text("삭제",
                              style: theme.textTheme.subtitle1!
                                  .copyWith(color: AppColors.black12))));
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
