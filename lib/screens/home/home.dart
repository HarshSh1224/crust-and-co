import 'package:crust_and_co/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:crust_and_co/blocs/authentication_bloc/authentication_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crust & Co. Home'),
        actions: [
          IconButton(
              onPressed: () => _onPresssedLogout(context),
              icon: const Icon(Icons.power_settings_new_rounded))
        ],
      ),
      body: Text(
          context.read<AuthenticationBloc>().userRepository.currentUser.email),
    );
  }

  _onPresssedLogout(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Log out?'),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await context
                    .read<AuthenticationBloc>()
                    .userRepository
                    .signOut();
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationUserChanged(MyUser.empty));
              },
              child: const Text('Yes')),
          TextButton(
              onPressed: Navigator.of(context).pop, child: const Text('No'))
        ],
      ),
    );
  }
}
