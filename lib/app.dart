import 'package:crust_and_co/app_view.dart';
import 'package:crust_and_co/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:crust_and_co/blocs/theme_bloc/crust_theme.dart';
import 'package:crust_and_co/blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) =>
                AuthenticationBloc(userRepository: userRepository)),
        RepositoryProvider(create: (context) => ThemeBloc(CrustTheme.dark()))
      ],
      child: MyAppView(userRepository),
    );
  }
}
