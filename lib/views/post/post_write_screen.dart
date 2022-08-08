
import 'package:eco_process/blocs/user_repository/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/post/bloc.dart';
import '../../blocs/post_controller.dart';
import '../../models/post.dart';
import '../../routes/routes.dart';
import '../../style/colors.dart';
import '../../style/tokens.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PostWriteScreen extends StatefulWidget {
  static const routeName = '/write';

  const PostWriteScreen() : super();

  @override
  _PostWriteScreenState createState() => _PostWriteScreenState();
}

class _PostWriteScreenState extends State<PostWriteScreen> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController contentEditingController = TextEditingController();
  late final PostBloc _getPostBloc;
  late final UserRepositoryBloc _getUserBloc;
  final _postController = Get.find<PostController>();

  @override
  void initState() {
    super.initState();
    print('인잇');
    _getPostBloc = BlocProvider.of<PostBloc>(context);
    _getUserBloc = BlocProvider.of<UserRepositoryBloc>(context);
    _postController.titleInputSub.sink.add(false);
    _postController.contentInputSub.sink.add(false);
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
          title: Text("글쓰기"),
          actions: [
            GetBuilder<PostController>(builder: (_) {
              return Container(
                  margin: EdgeInsets.only(top: 6, bottom: 6, right: 6),
                  decoration: BoxDecoration(
                      color:
                      Colors.lightBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child:
                  Row(
                    children: [

                      _.isUserWritedText == true
                          ?
                      TextButton(
                          onPressed: () async {
                            _getPostBloc.add(AddPostEvent(
                                post: Post(writer: _getUserBloc.blocLoginUser, isCreatedAt: '', title: titleEditingController!.text,
                                    content: contentEditingController!.text, deleteFlag: 'N')));

                            debugPrint('사용자 입력 트루');

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('글 작성이 완료되었습니다')));
                            // Navigator.of(context).pushNamed('/board');
                            Navigator.of(context).pushNamedAndRemoveUntil(Routes.board, (route) => false);
                          },
                          child:
                          AutoSizeText(
                            '등록',
                            style: TextStyle(fontSize: 20, color: AppColors.white),
                            maxLines: 1,
                          )
                              ) :
                      TextButton(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('글 제목과 내용을 모두 입력해주세요')));
                          },
                          child:
                          AutoSizeText(
                            '등록',
                            style: TextStyle(fontSize: 20, color: AppColors.chipBlue),
                            maxLines: 1,
                          ),
                      )
                      ],
                  )
                  );
            })
          ],
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) {
            final appWidth = boxConstraints.maxWidth;
            final appHeight = boxConstraints.maxHeight;
            return SingleChildScrollView(
                child: SafeArea(
                    child: Container(
                      // color: Colors.lightBlueAccent,
              height: appHeight,
              // width: width,
              child: Column(
                children: [
                  AppSpacers.height24,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        width: 200,
                        padding: AppEdgeInsets.horizontal16,
                    ),
                  ),
                  Container(
                    padding: AppEdgeInsets.horizontal16,
                    child: TextField(
                      controller: titleEditingController,
                      style: theme.textTheme.subtitle1!
                          .apply(color: AppColors.text50),
                      decoration: InputDecoration(
                          hintStyle: theme.textTheme.subtitle1!
                              .apply(color: AppColors.text40),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          counter: SizedBox(
                            width: 0,
                            height: 0,
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 0, bottom: 11, top: 11, right: 15),
                          hintText: "제목을 입력해 주세요."),
                      maxLength: 30,
                      maxLines: 1,
                      onChanged: (text) {
                        if (0 < text.length) {
                          _postController.titleInputSub.sink.add(true);
                        } else if (text.length == 0) {
                          _postController.titleInputSub.sink.add(false);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: AppEdgeInsets.horizontal16,
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: AppColors.border,
                    ),
                  ),
                  Container(
                    padding: AppEdgeInsets.horizontal16,
                    child: TextField(
                      maxLength: 500,
                      maxLines: null,
                      controller: contentEditingController,
                      decoration: InputDecoration(
                        hintStyle: theme.textTheme.bodyText2!
                            .apply(color: AppColors.text40),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 0, bottom: 11, top: 11, right: 15),
                        hintText: "내용을 입력해 주세요.",
                        counter: SizedBox(
                          width: 0,
                          height: 0,
                        ),
                      ),
                      style: theme.textTheme.bodyText2!
                          .apply(color: AppColors.text50),
                      onChanged: (text) {

                        if (0 < text.length) {
                          _postController.contentInputSub.sink.add(true);
                        } else if (text.length == 0) {
                          _postController.contentInputSub.sink.add(false);
                        }
                      },
                    ),
                  ),
                  AppSpacers.height24,
                ],
              ),
            )));
          },
        ));
  }

  @override
  dispose() async{
    debugPrint('>>>>> Dispose post_write_screen ');
    titleEditingController.dispose();
    contentEditingController.dispose();
    super.dispose();
  }

}
