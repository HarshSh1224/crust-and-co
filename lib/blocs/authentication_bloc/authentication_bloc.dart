import 'package:bloc/bloc.dart';
import 'package:crust_and_co/blocs/authentication_bloc/authentication_events.dart';
import 'package:crust_and_co/blocs/authentication_bloc/authentication_states.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(const AuthenticationState.unknown()) {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      userRepository.trySignIn().then((success) {
        add(AuthenticationUserChanged(userRepository.currentUser));
      });
    });

    on<AuthenticationUserChanged>((event, emit) {
      if (!event.user.isNotValid) {
        emit(AuthenticationState.authenticated(event.user));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });

    on<SignOutRequested>(((event, emit) {
      userRepository.signOut();
      emit(const AuthenticationState.unauthenticated());
    }));
  }
}
