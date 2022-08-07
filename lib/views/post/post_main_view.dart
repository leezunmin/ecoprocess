import 'package:eco_process/main.dart';
import 'package:eco_process/views/login.dart';
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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostMainView extends StatefulWidget {
  static const routeName = '/board';

  @override
  State createState() => PostMainViewState();
}

class PostMainViewState extends State<PostMainView> {
  // late final NavigatorState _rootNavi;
  final _scrollController = ScrollController();
  late final PostBloc _getPostBloc;
  late final UserRepositoryBloc _getUserBloc;
  String imgUrl = "";

  @override
  void initState() {
    super.initState();
    print('PostMainViewState initState ');
    _getPostBloc = BlocProvider.of<PostBloc>(context);
    _getUserBloc = BlocProvider.of<UserRepositoryBloc>(context);
    // _rootNavi = context.read<NaviRepository>().mainKey.currentState!;

    confirmURL();
  }

  confirmURL() async {
    imgUrl = await FirebaseStorage.instance
        .ref()
        .child('photo')
        .child('/rabbit.jpg')
        .getDownloadURL();
    String url2 = await FirebaseStorage.instance
        .ref()
        .child('photo/rabbit.jpg')
        .getDownloadURL();

    print('imgUrl 출력 ' + imgUrl);
    print('url2 출력 ' + url2);
  }

  @override
  Widget build(BuildContext context) {
    _getPostBloc.add(Fetch());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    //  imgRef = FirebaseStorage.instance.ref().child('photo').child('/rabbit.jpg');
    // Reference imgRef = FirebaseStorage.instance.ref().child('photo/rabbit.jpg');

    return Scaffold(
        appBar: AppBar(
            elevation: 1,
            title: Container(
                width: screenWidth,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            // color: Colors.black,
                            width: screenWidth * 0.15,
                            child: Text(
                              "게시판",
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(width: screenWidth * 0.07),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // AppSpacers.width18,
                            Container(
                              width: screenWidth * 0.3,
                              child: BlocBuilder<UserRepositoryBloc,
                                      UserRepositoryState>(
                                  buildWhen: (previous, current) =>
                                      previous != current &&
                                      current is UserStatus,
                                  builder: (BuildContext context,
                                      UserRepositoryState state) {
                                    if (state is UserInitStatus) {
                                      return Container(
                                          // color: Colors.black12,
                                          width: screenWidth * 0.3,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text("비로그인",
                                                      overflow: TextOverflow
                                                          .ellipsis))
                                            ],
                                          ));
                                    } else if (state is UserStatus) {
                                      return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          width: screenWidth * 0.3,
                                          margin: EdgeInsets.only(left: 4),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      state.currentUser!.email +
                                                          "  님 로그인",
                                                      overflow: TextOverflow
                                                          .ellipsis))
                                            ],
                                          ));
                                    } else {
                                      return Text('비로그인');
                                    }
                                  }),
                            ),

                            SizedBox(width: screenWidth * 0.07),
                            Container(
                                decoration: BoxDecoration(
                                    // color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(20)),
                                width: screenWidth * 0.18,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
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
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                          (states) {
                                            if (states.contains(
                                                MaterialState.disabled)) {
                                              return Color.fromRGBO(
                                                  38, 38, 38, 0.4);
                                            } else {
                                              return Color(0x9fffffff);
                                            }
                                          },
                                        ),
                                      ),
                                      child:

                                          // Text('글쓰기',
                                          //     textAlign: TextAlign.end,
                                          //     overflow: TextOverflow.ellipsis)

                                          Container(
                                              child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text('글쓰기',
                                            // textAlign: TextAlign.end,
                                            overflow: TextOverflow.ellipsis),
                                      )),
                                    ),
                                  ],
                                )),
                            // AppSpacers.width70,
                          ],
                        ),
                      ],
                    ),
                    AppSpacers.height8,
                  ],
                ))),
        body: ConstrainedBox(
            // constraints: const BoxConstraints.expand(),
            constraints: BoxConstraints(
                minHeight: screenHeight * 0.4,
                minWidth: double.infinity,
                maxHeight: screenHeight),
            child: Container(
              width: screenWidth,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  AppSpacers.height16,
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
                                            width: screenWidth * 0.7,
                                            child: InkWell(
                                              onTap: () {
                                                onSelectCell(state.postList
                                                    .elementAt(index));
                                              },
                                              child: PostCard(
                                                  state.postList
                                                      .elementAt(index),
                                                  imgUrl),
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
                  AppSpacers.height16,
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return PostWriteScreen();
              }),
            );
          },
          label: const Text('글쓰기'),
          icon: const Icon(Icons.add_comment_outlined),
          backgroundColor: Colors.pinkAccent,
        ));
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
