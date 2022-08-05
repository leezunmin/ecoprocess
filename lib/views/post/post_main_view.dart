import 'package:eco_process/views/post/post_read_screen.dart';
import 'package:eco_process/views/post/post_write_screen.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../blocs/post/bloc.dart';
import '../../blocs/user_repository/bloc.dart';
import '../../models/post.dart';
import '../../routes/navi_repository.dart';
import '../../routes/routes.dart';
import '../../style/colors.dart';
import '../../style/tokens.dart';
import '../widget/post_card.dart';

class PostMainView extends StatefulWidget {
  static const routeName = '/board';

  @override
  State createState() => PostMainViewState();
}

class PostMainViewState extends State<PostMainView> {
  late final NavigatorState _rootNavi;
  final _scrollController = ScrollController();
  late final PostBloc _getPostBloc;

  @override
  void initState() {
    super.initState();
    print('PostMainViewState initState ');
    _getPostBloc = BlocProvider.of<PostBloc>(context);
    _rootNavi = context.read<NaviRepository>().mainKey.currentState!;
  }

  @override
  Widget build(BuildContext context) {
    _getPostBloc.add(Fetch());
    final screentHeight = MediaQuery.of(context).size.height;
    final screentWidth = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            elevation: 1,
            title: Row(
              children: [
                Text("게시판"),
                AppSpacers.width70,
                BlocBuilder<UserRepositoryBloc, UserRepositoryState>(
                    // buildWhen: (previous, current) => previous != current && current is LoadedComment,
                    builder: (BuildContext context, UserRepositoryState state) {
                  if (state is UserInitStatus) {
                    return Text('비로그인');
                  } else if (state is UserStatus) {
                    return ElevatedButton(
                      onPressed: () async {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Color.fromRGBO(38, 38, 38, 0.4);
                            } else {
                              return Color(0x9fffffff);
                            }
                          },
                        ),
                      ),
                      child: Text(state.currentUser!.email + "  님 로그인"),
                    );
                  } else {
                    return Text('비로그인');
                  }
                }),
                AppSpacers.width70,
                ElevatedButton(
                  onPressed: () async {
                    // _rootNavi = context.read<NaviRepository>().mainKey.currentState!;
                    // _rootNavi.pushNamed(Routes.write, arguments: '글쓰기');

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PostWriteScreen();
                      }),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Color.fromRGBO(38, 38, 38, 0.4);
                        } else {
                          return Color(0x9fffffff);
                        }
                      },
                    ),
                  ),
                  child: Text('글쓰기'),
                ),
                AppSpacers.width70,
              ],
            )),
        body: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Container(
              width: screentWidth,
              // color: Colors.black38,
              // margin: AppEdgeInsets.vertical8.add(AppEdgeInsets.horizontal16),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  AppSpacers.height80,
                  BlocBuilder<PostBloc, PostState>(
                      buildWhen: (previous, current) =>
                          previous != current && current is Loaded,
                      builder: (BuildContext context, PostState state) {
                        if (state is Loaded) {
                          if (state.postList.isEmpty) {
                            print('state.postList.isEmpty >> ');
                            return Center(
                                child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.3),
                                Text('게시글이 존재하지 않습니다.'),
                                /* CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),*/
                                SizedBox(height: 40)
                              ],
                            ));
                          }
                          return Expanded(
                              child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: state.postList.length,
                                  // itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      indent: 16,
                                      endIndent: 16,
                                      thickness: 2,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    if (state.postList.isEmpty) {
                                      return Text('no Post');
                                    } else {
                                      return LayoutBuilder(builder:
                                          (BuildContext context,
                                              BoxConstraints constraints) {
                                        final containerWidth =
                                            constraints.maxWidth;
                                        return Container(
                                            // color: Colors.red,
                                            width: screentWidth * 0.7,
                                            child: InkWell(
                                              onTap: () {
                                                onSelectCell(state.postList.elementAt(index));
                                              },
                                              child: PostCard(state.postList
                                                  .elementAt(index)),
                                            ));
                                      });
                                    }
                                  }));
                        }

                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              // AppSpacers.height80,
                              // AppSpacers.height80,
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  AppSpacers.height80,
                ],
              ),
            )));
  }

  void onSelectCell(Post? post) {

    // _rootNavi.push((MaterialPageRoute(
    //     builder: (context) => Provider?.value(
    //       value: _rootNavi,
    //       builder: (context, child) {
    //         return MultiBlocProvider(
    //           providers: [
    //           ],
    //           child: CommunityReaderScreen(post!),
    //         );
    //       },
    //     ))));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostReadScreen(post!),
      ),
    );


  }

}
