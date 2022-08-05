part of 'bloc.dart';

@immutable
abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

/*class GetInit extends PostState {
  final List<AppPost>? postList;
  final AppPostSortEnum? currentSort;
  final AppPostHeaderEnum? currentHeader;

  const GetInit({this.postList, this.currentSort, this.currentHeader});

  @override
  List<Object> get props => [postList!, currentSort!, currentHeader!];

  @override
  String toString() => 'getInitial { items: ${postList!.length} }';
}*/

class GetInit extends PostState {
  final List<Post>? postList;
  // final AppPostSortEnum? currentSort;
  // final AppPostHeaderEnum? currentHeader;

  const GetInit({this.postList
    // , this.currentSort, this.currentHeader
  });

  @override
  List<Object> get props => [postList!,
    // currentSort!, currentHeader!
  ];

  @override
  String toString() => 'getInitial { items: ${postList!.length} }';
}


class Loaded extends PostState {
  // final List<AppPost> postList;
  final List<Post> postList;
  // final AppPostSortEnum? currentSort;
  // final AppPostHeaderEnum? currentHeader;
  final bool? isValidated;
  final bool? isIncludeVote;

  const Loaded(
      {
        // required this.postList,
        // this.currentSort,
        // this.currentHeader,
        required this.postList,
        this.isValidated,
        this.isIncludeVote});

  @override
  List<Object> get props => [postList];

  @override
  String toString() => 'Loaded { items: ${postList.length} }';
}
