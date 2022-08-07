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

  Login({
    this.currentUser,
    this.googleSignIn,
  });

  @override
  List<Object> get props => [
        currentUser!,
        googleSignIn!,
      ];
}

class LogOut extends UserRepositoryEvent {
  final GoogleSignInAccount? currentUser;
  final GoogleSignIn? googleSignIn;

  LogOut({
    this.currentUser,
    this.googleSignIn,
  });

  @override
  List<Object> get props => [
    currentUser!,
    googleSignIn!,
  ];
}

