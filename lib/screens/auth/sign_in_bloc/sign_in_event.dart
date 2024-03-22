part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequired extends SignInEvent {
  String email;
  String password;

  SignInRequired({
    required this.email,
    required this.password,
  });
}
