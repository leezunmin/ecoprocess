part of 'bloc.dart';

@immutable
abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}


class GetInit extends PostState {
  final List<Post>? postList;

  const GetInit({this.postList});

  @override
  List<Object> get props => [postList!];
}


class Loaded extends PostState {
  final List<Post> postList;

  const Loaded({required this.postList});

  @override
  List<Object> get props => [postList];

  @override
  String toString() => 'Loaded { items: ${postList.length} }';
}
