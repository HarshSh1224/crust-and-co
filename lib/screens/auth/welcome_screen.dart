import 'package:crust_and_co/components/space.dart';
import 'package:crust_and_co/screens/auth/ui/signin_screen.dart';
import 'package:crust_and_co/screens/auth/ui/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen(this.userRepository, {super.key});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Crust & Co.'),
      ),
      body: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to Crust & Co.'),
            const Text('Please sign in or sign up'),
            const Space(),
            const Space(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SigninScreen(userRepository)));
                },
                child: const Text('Sign in')),
            const Space(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
                },
                child: const Text('Sign up')),
          ],
        )),
      ),
    );
  }
}
