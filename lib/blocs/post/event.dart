part of 'bloc.dart';

@immutable
abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialOnce extends PostEvent {}


class Fetch extends PostEvent {}

// class FetchNext extends PostEvent {
//   final AppPostHeaderEnum? currentHeader;
//   final AppPostSortEnum? currentSort;
//
//   //다음 페이징을 위한 비교값
//   final List<AppPost>? postList;
//
//   FetchNext({this.currentHeader, this.currentSort, this.postList});
//
//   @override
//   List<Object> get props => [postList!];
// }

class AddPostEvent extends PostEvent {

  final Post post;
  final String? title;
  final String? text;
  final String? ownerId;
  final String? nickName;

  final bool? voteActivate;
  // final List<AppVoteItem>? voteList;
  // final AppVote? vote;

  AddPostEvent(
      {
        required this.post,
        this.title,
        this.text,
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
    post,
    title!,
    text!,
    ownerId!,
    nickName!,
    // imgDownload!,
    // deleteImgPath!,
    voteActivate!,
    // {voteList, vote}
  ];
}

// class SetFilter extends PostEvent {
//   //게시글 필터
//   final AppPostHeaderEnum? currentHeader;
//   final AppPostSortEnum? currentSort;
//
//   SetFilter({this.currentHeader, this.currentSort});
//
//   // 필터 여러번 걸때를 위한 이벤트 처리
//   @override
//   List<Object> get props => [currentHeader!, currentSort!];
// }
//
// // class LikePost extends PostEvent {}
//
// class EditPost extends PostEvent {
//   final String? postUid;
//   final String? title;
//   final String? text;
//   final String? ownerId;
//   final String? nickName;
//   final AppPostHeaderEnum? header;
//   final AppVote? vote;
//   final String? imgDownload;
//   final String? deleteImgPath;
//
//   EditPost(
//       {this.postUid,
//         this.title,
//         this.text,
//         this.ownerId,
//         this.nickName,
//         this.header,
//         this.vote,
//         this.imgDownload,
//         this.deleteImgPath});
//   // 게시글 수정 인식
//   @override
//   List<Object> get props =>
//       [title!, text!, ownerId!, header!, imgDownload!, deleteImgPath!];
// }
//
// class RemovePost extends PostEvent {
//   final String postUid;
//   final String? deleteImgPath;
//   RemovePost(this.postUid, {this.deleteImgPath});
// }
