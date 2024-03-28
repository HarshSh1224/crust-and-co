import 'package:crust_and_co/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crust & Co. Home'),
      ),
      body: Text(
          context.read<AuthenticationBloc>().userRepository.currentUser.email),
    );
  }
}
