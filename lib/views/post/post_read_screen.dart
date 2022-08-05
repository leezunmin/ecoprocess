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

class PostReadScreen extends StatefulWidget {
  static const routeName = '/read';

  const PostReadScreen() : super();

  @override
  _PostReadScreenState createState() => _PostReadScreenState();
}

class _PostReadScreenState extends State<PostReadScreen> {


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
                  Text('게시글 읽기')
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
