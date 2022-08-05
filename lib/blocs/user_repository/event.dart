// abstract class UserRepositoryEvent {}
//
// class InitEvent extends UserRepositoryEvent {}
//


part of 'bloc.dart';

@immutable
abstract class UserRepositoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}



class Login extends UserRepositoryEvent {

  final GoogleSignInAccount? currentUser;
  final GoogleSignIn? googleSignIn;
  final String? ownerId;
  final String? nickName;

  final bool? voteActivate;
  // final List<AppVoteItem>? voteList;
  // final AppVote? vote;

  Login(
      {
        this.currentUser,
        this.googleSignIn,
        this.ownerId,
        this.nickName,
        // this.header,
        // this.imgDownload,
        // this.deleteImgPath,
        this.voteActivate,
        // this.voteList,
        // this.vote

      });

  // 게시글 여러번 입력 시
  @override
  List<Object> get props => [
    currentUser!,
    googleSignIn!,
    ownerId!,
    nickName!,
    // imgDownload!,
    // deleteImgPath!,
    voteActivate!,
    // {voteList, vote}
  ];
}

