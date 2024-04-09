import 'package:crust_and_co/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:crust_and_co/blocs/authentication_bloc/authentication_events.dart';
import 'package:crust_and_co/blocs/theme_bloc/crust_theme.dart';
import 'package:crust_and_co/blocs/theme_bloc/theme_bloc.dart';
import 'package:crust_and_co/components/widgets/hyperlinked_text.dart';
import 'package:crust_and_co/components/widgets/loading_indicator.dart';
import 'package:crust_and_co/components/widgets/primary_button.dart';
import 'package:crust_and_co/components/widgets/space.dart';
import 'package:crust_and_co/components/widgets/text_input.dart';
import 'package:crust_and_co/constants/app_language.dart';
import 'package:crust_and_co/constants/assets.dart';
import 'package:crust_and_co/screens/auth/sign_in_bloc/sign_in_bloc.dart';
import 'package:crust_and_co/screens/auth/ui/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen(this.userRepository, {super.key});

  final UserRepository userRepository;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = BlocProvider.of<ThemeBloc>(context).crustTheme;
    return BlocProvider(
      create: (context) => SignInBloc(userRepository),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.background,
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
              return Center(
                child: SizedBox(
                    height: screenSize.height * 0.1,
                    width: screenSize.height * 0.1,
                    child: const LoadingIndicator()),
              );
            }
            return _body(
                context, _formKey, _emailController, theme, _passwordController,
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

  Widget _body(context, formKey, emailController, CrustTheme theme,
      passwordController, onSubmit) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Opacity(
                              opacity: 0.8,
                              child: Image.asset(Assets.appLogo, height: 50)),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        'Welcome',
                        style: GoogleFonts.montserrat(
                            fontSize: 34,
                            color: theme.primaryText,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Back',
                        style: GoogleFonts.montserrat(
                            fontSize: 34,
                            color: theme.primaryText,
                            fontWeight: FontWeight.w700),
                      ),
                      const Space(),
                      Text(
                        'Login with email and password',
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: theme.secondaryText,
                            fontWeight: FontWeight.w300),
                      ),
                      const Space(
                        heightFactor: 3,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 6,
                  child: _form(context, emailController, theme,
                      passwordController, onSubmit))
            ],
          ),
        ),
      ),
    );
  }

  Widget _form(context, emailController, CrustTheme theme, passwordController,
      Function(String, String) onSubmit) {
    return Column(
      children: <Widget>[
        const Space(heightFactor: 3),
        TextInput(
          controller: emailController,
          hintText: AppLanguage.email,
          trailing: Icons.person,
        ),
        const Space(heightFactor: 3),
        TextInput(
          controller: passwordController,
          hintText: AppLanguage.password,
          obscureText: true,
          trailing: Icons.lock,
        ),
        const Space(heightFactor: 7),
        PrimaryButton(
            onPressed: () {
              if (true) {
                onSubmit(_emailController.text, _passwordController.text);
              }
            },
            text: AppLanguage.submit),
        const Space(heightFactor: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'New User? ',
              style:
                  GoogleFonts.rubik(fontSize: 14, color: theme.secondaryText),
            ),
            HyperlinkedText(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupScreen(userRepository)));
              },
              text: 'Sign Up',
              style: GoogleFonts.rubik(
                  fontSize: 14,
                  color: theme.secondaryText,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
