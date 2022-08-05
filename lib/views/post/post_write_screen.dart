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
import '../../blocs/post/post_controller.dart';
import '../../models/post.dart';
import '../../routes/navi_repository.dart';
import '../../style/colors.dart';
import '../../style/tokens.dart';
import 'package:get/get.dart';

class PostWriteScreen extends StatefulWidget {
  static const routeName = '/write';

  const PostWriteScreen() : super();

  @override
  _PostWriteScreenState createState() => _PostWriteScreenState();
}

// class _CommunityWriteScreenState extends State<CommunityWriteScreen> with AppStatefulViewMixin, ValidatorMixin, BlocInterface {

class _PostWriteScreenState extends State<PostWriteScreen> {
  final TextEditingController? titleEditingController = TextEditingController();
  final TextEditingController? contentEditingController =
      TextEditingController();

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
    titleEditingController!.dispose();
    contentEditingController!.dispose();
    imgProgress.close();
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
          title: Text("글쓰기2"),
          actions: [
            GetBuilder<PostController>(builder: (_) {
              return Container(
                  // width: 65,
                  // height: 30,
                  margin: EdgeInsets.only(top: 14, bottom: 14, right: 20),
                  padding: EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                      color:
                      Colors.lightBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () async {
                        print('글 제목' + titleEditingController!.text);

                        _getPostBloc.add(AddPostEvent(title: titleEditingController!.text, post: Post(writer: '11', isCreatedAt: '22', title: '33', content: '44')));
                        // _rootNavi.pushNamed(Routes.board, arguments: '메인뷰');

                        debugPrint('사용자 입력 트루');

                        Navigator.of(context).pushNamed('/board');
                      },
                      child: _.isUserWritedText == true
                          ? Text("등록",
                              style: theme.textTheme.subtitle1!
                                  .copyWith(color: AppColors.white))
                          : Text("등록",
                              style: theme.textTheme.subtitle1!
                                  .copyWith(color: AppColors.chipBlue))));
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
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Row(
                              children: [],
                            ),
                          ),
                        )),
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
                        if (0 < text.trim().length) {
                          _getPostBloc.textInputSub.sink.add(true);
                        } else if (text.trim().length == 0) {
                          _getPostBloc.textInputSub.sink.add(false);
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
                    ),
                  ),
                  AppSpacers.height24,
                  // _blocWidget(boxConstraints),

                  /*imgLoading == true
                              ? Container(
                              padding: AppEdgeInsets.bottom32, child: showProgres())
                              : SizedBox(),*/
                  // SizedBox(height: 20),
                ],
              ),
            )));
          },
        ));
  }

  /*_onAddButton(BuildContext context) {
    final _imgBloc = BlocProvider.of<ImageBloc>(context);

    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return PhotoSelectorBottomSheet(
            onPick: (file) async {
              l.info(this, 'file >>> ' + file.toString());
              imgProgress.sink.add(true);
              if (file != null) {
                _imgBloc.add(GetLoadImage(file));
              }
            },
            onPhotoPicker: () {},
          );
        });
  }*/

  /*Widget _blocWidget(BoxConstraints viewportConstraints) {
    final _imgBloc = BlocProvider.of<ImageBloc>(context);
    final voteBlocState = BlocProvider.of<VoteBloc>(context).state;

    return Column(
      children: [
        // 상태에 대해 1회만 작동함, 라우팅으로 사용
        BlocListener<PostBloc, PostState>(
          listenWhen: (context, state) {
            return state is Loaded;
          },
          listener: (context, state) {
            if (state is Loaded) {
              if (state.isValidated == true) {
                print('state.isValidated == true ');
                // 라우팅 임시로 막음
                _rootNavi.pop();
              } else if (state.isValidated == true &&
                  state.isIncludeVote == true) {
                print('state.isIncludeVote == true ');
                // 라우팅 임시로 막음
                _rootNavi.pop();
                _rootNavi.pop();
              }
            }
          },
          child: Container(),
        ),

        BlocBuilder<ImageBloc, ImageBlocState>(
          // 사진 지웠을때랑 사진 첨부했을때 빌드됨
            buildWhen: (previous, current) =>
            (current is ImagePickerSuccess || current is ImagePickerEmpty),
            builder: (BuildContext context, ImageBlocState state) {
              print('Community Write ImageBlocState >> ' + state.toString());

              if (state is ImagePickerEmpty) {
                l.info(this, 'BlocBuilder state is ImagePickerEmpty ');
                return Container();
              } else if (state is ImagePickerLoading) {
                l.info(this, 'ImagePickerLoading');
                return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ));
              }


              else if (state is ImagePickerSuccess) {
                // 이미지 첨부가 새로 되면 첨부여부 초기화
                imgProgress.sink.add(false);

                return Container(
                  width: viewportConstraints.maxWidth - 30,
                  height: viewportConstraints.maxHeight - 300,
                  decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.circular8,
                      border: Border.all(width: 1, color: AppColors.gray[030]!),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            state.imgDownload.toString()),
                      )),
                  child: Align(
                    alignment: FractionalOffset(0.99, 0.01),
                    //사진 삭제 아이콘
                    child: IconButton(
                      icon: ImageIcon(Assets.images.icCancelSolidBl24,
                          color: AppColors.gray[60]),
                      onPressed: () {
                        _imgBloc.add(
                            CancleImage(deleteImgPath: state.deleteImgPath));
                      },
                    ),
                  ),
                );
              }
              return SizedBox();
            }),

        SizedBox(height: 50),

        // voteBlocState.runtimeType == EditingVoteListState
        //     ? VoteBlocEditor()
        //     : SizedBox(),

        SizedBox(height: 50),
      ],
    );
  }*/
}
