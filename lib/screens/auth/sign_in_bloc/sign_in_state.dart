part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
  
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInProcessing extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {
  final String message;
  
  const SignInError({
    required this.message,
  });

}
