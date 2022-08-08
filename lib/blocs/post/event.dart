part of 'bloc.dart';

@immutable
abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialOnce extends PostEvent {}

class Fetch extends PostEvent {}

class AddPostEvent extends PostEvent {
  final Post post;

  AddPostEvent({
    required this.post,
  });

  @override
  List<Object> get props => [post];
}

class RemovePostEvent extends PostEvent {
  final String uid;

  RemovePostEvent({
    required this.uid,
  });
  @override
  List<Object> get props => [uid];
}


