// class UserRepositoryState {
//   UserRepositoryState init() {
//     return UserRepositoryState();
//   }
//
//   UserRepositoryState clone() {
//     return UserRepositoryState();
//   }
// }
//
// class InitialUserRepositoryState extends UserRepositoryState {
//
// }

part of 'bloc.dart';

@immutable
abstract class UserRepositoryState extends Equatable {
  const UserRepositoryState();

  @override
  List<Object> get props => [];
}

class UserInitStatus extends UserRepositoryState {
  const UserInitStatus();

  @override
  List<Object> get props => [];
}

class UserStatus extends UserRepositoryState {
  final bool isLogin;
  final GoogleSignInAccount? currentUser;
  final GoogleSignIn? googleSignIn;

  const UserStatus(this.isLogin, {this.currentUser, this.googleSignIn} );

  @override
  List<Object> get props => [];

  @override
  String toString() => 'UserStatus { isLogin: ${isLogin}, currentUser: ${currentUser}, googleSignIn: ${googleSignIn}, }';
}
