import 'package:crust_and_co/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:crust_and_co/blocs/authentication_bloc/authentication_states.dart';
import 'package:crust_and_co/screens/auth/welcome_screen.dart';
import 'package:crust_and_co/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyAppView extends StatelessWidget {
  const MyAppView(this.userRepository, {super.key});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crust & Co.',
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return const HomeScreen();
          } else {
            return WelcomeScreen(userRepository);
          }
        },
      ),
    );
  }
}
