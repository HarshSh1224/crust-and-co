import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.myUser,
  });

  final AuthenticationStatus status;
  final MyUser? myUser;

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.authenticated(MyUser user)
      : this._(status: AuthenticationStatus.authenticated, myUser: user);

  @override
  List<Object?> get props => [status, myUser];
}
