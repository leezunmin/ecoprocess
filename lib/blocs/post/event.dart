part of 'bloc.dart';

@immutable
abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialOnce extends PostEvent {}

class Fetch extends PostEvent {}

class AddPostEvent extends PostEvent {
  final String writer;
  final String isCreatedAt;
  final String title;
  final String content;

  AddPostEvent({
    required this.writer,
    required this.isCreatedAt,
    required this.title,
    required this.content
  });

  @override
  List<Object> get props => [writer, isCreatedAt, title, content];
}

class RemovePostEvent extends PostEvent {
  final String uid;

  RemovePostEvent({
    required this.uid,
  });
  @override
  List<Object> get props => [uid];
}


