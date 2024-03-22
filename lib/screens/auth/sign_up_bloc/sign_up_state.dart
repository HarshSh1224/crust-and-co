part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpProcessing extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  String message;
  
  SignUpError({
    required this.message,
  });

  
}
