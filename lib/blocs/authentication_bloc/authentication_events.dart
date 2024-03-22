import 'package:user_repository/user_repository.dart';

abstract class AuthenticationEvent {}

class AuthenticationUserChanged extends AuthenticationEvent {
  final MyUser user;

  AuthenticationUserChanged(this.user);
}
