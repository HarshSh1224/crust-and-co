import 'package:crust_and_co/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:crust_and_co/blocs/authentication_bloc/authentication_events.dart';
import 'package:crust_and_co/components/loading_indicator.dart';
import 'package:crust_and_co/components/space.dart';
import 'package:crust_and_co/screens/auth/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen(this.userRepository, {super.key});

  final UserRepository userRepository;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(userRepository),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationUserChanged(userRepository.currentUser));
              Navigator.of(context).pop();
            }
            if (state is SignInError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is SignInProcessing) {
              return const Center(
                child:
                    SizedBox(height: 85, width: 85, child: LoadingIndicator()),
              );
            }
            return _form(_formKey, _emailController, _passwordController,
                (email, password) {
              context
                  .read<SignInBloc>()
                  .add(SignInRequired(email: email, password: password));
            });
          },
        ),
      ),
    );
  }

  Widget _form(formKey, emailController, passwordController,
      Function(String, String) onSubmit) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const Space(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  onSubmit(_emailController.text, _passwordController.text);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
