import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

abstract class AuthenticationEvent extends Equatable {}

class AuthenticationUserChanged extends AuthenticationEvent{
  final MyUser user;

  @override
  List<Object> get props => [user];

  AuthenticationUserChanged(this.user);
}