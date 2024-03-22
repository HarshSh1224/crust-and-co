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
    userRepository.trySignIn().then((success) {
      add(AuthenticationUserChanged(userRepository.currentUser));
    });

    on<AuthenticationUserChanged>((event, emit) {
      if (!event.user.isNotValid) {
        print(userRepository.currentUser.toMap());
        emit(AuthenticationState.authenticated(event.user));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }
}
