part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  MyUser myUser;
  String password;

  SignUpRequired({
    required this.myUser,
    required this.password,
  });
}
