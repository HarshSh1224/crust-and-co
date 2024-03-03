import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crust_and_co/blocs/authentication_bloc/authentication_events.dart';
import 'package:crust_and_co/blocs/authentication_bloc/authentication_states.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  final UserRepository userRepository;
  late StreamSubscription<MyUser> _userSubscription;

  @override
  AuthenticationBloc({
    required this.userRepository,
  }) : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });
    on<AuthenticationUserChanged>((event, emit) {
      if(event.user == MyUser.empty){
        emit(const AuthenticationState.unauthenticated());
      } else {
        emit(AuthenticationState.authenticated(event.user));
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}