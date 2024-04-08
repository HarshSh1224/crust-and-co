import 'package:crust_and_co/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:crust_and_co/blocs/authentication_bloc/authentication_states.dart';
import 'package:crust_and_co/blocs/theme_bloc/theme_bloc.dart';
import 'package:crust_and_co/constants/app_language.dart';
import 'package:crust_and_co/screens/welcome_screen.dart';
import 'package:crust_and_co/screens/home/home.dart';
import 'package:crust_and_co/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyAppView extends StatelessWidget {
  const MyAppView(this.userRepository, {super.key});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppLanguage.crustAndCo,
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state1) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _buildPage(context, state),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPage(context, state) {
    if (state.status == AuthenticationStatus.unknown) {
      return const SplashScreen();
    } else if (state.status == AuthenticationStatus.authenticated) {
      return const HomeScreen();
    } else {
      return WelcomeScreen(userRepository);
    }
  }
}
