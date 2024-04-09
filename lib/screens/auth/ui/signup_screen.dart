import 'package:crust_and_co/blocs/theme_bloc/crust_theme.dart';
import 'package:crust_and_co/blocs/theme_bloc/theme_bloc.dart';
import 'package:crust_and_co/components/widgets/loading_indicator.dart';
import 'package:crust_and_co/components/widgets/primary_button.dart';
import 'package:crust_and_co/components/widgets/space.dart';
import 'package:crust_and_co/components/widgets/text_input.dart';
import 'package:crust_and_co/constants/app_language.dart';
import 'package:crust_and_co/constants/assets.dart';
import 'package:crust_and_co/screens/auth/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen(this.userRepository, {super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();

  final UserRepository userRepository;
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BlocProvider.of<ThemeBloc>(context).crustTheme;
    return BlocProvider(
      create: (context) => SignUpBloc(widget.userRepository),
      child: Scaffold(
        backgroundColor: theme.background,
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(AppLanguage.successPleaseLogin)));
              Navigator.of(context).pop();
            }
            if (state is SignUpError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is SignUpProcessing) {
              final screenHeight = MediaQuery.of(context).size.height;
              return Center(
                child: SizedBox(
                    height: screenHeight * 0.1,
                    width: screenHeight * 0.1,
                    child: const LoadingIndicator()),
              );
            }
            return _body(context, theme);
          },
        ),
      ),
    );
  }

  Widget _body(context, theme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(flex: 4, child: _heading(theme)),
                Expanded(flex: 15, child: _signupForm(context, theme)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _heading(theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Opacity(
                opacity: 0.8, child: Image.asset(Assets.appLogo, height: 50)),
          ],
        ),
        const Spacer(),
        Text(
          'Sign Up',
          style: GoogleFonts.montserrat(
              fontSize: 34,
              color: theme.primaryText,
              fontWeight: FontWeight.w700),
        ),
        Text(
          'Create a new account',
          style: GoogleFonts.montserrat(
              fontSize: 16,
              color: theme.secondaryText,
              fontWeight: FontWeight.w300),
        ),
        const Space(
          heightFactor: 4,
        ),
      ],
    );
  }

  Form _signupForm(BuildContext context, CrustTheme theme) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Space(),
          TextInput(
            controller: _fullNameController,
            hintText: AppLanguage.fullName,
            trailing: Icons.person,
          ),
          const Space(
            heightFactor: 3,
          ),
          TextInput(
            controller: _emailController,
            hintText: AppLanguage.email,
            trailing: Icons.alternate_email_rounded,
          ),
          const Space(
            heightFactor: 3,
          ),
          TextInput(
            controller: _passwordController,
            hintText: AppLanguage.password,
            obscureText: true,
            trailing: Icons.lock,
          ),
          const Space(
            heightFactor: 3,
          ),
          TextInput(
            controller: _confirmPasswordController,
            hintText: AppLanguage.confirmPassword,
            obscureText: true,
            trailing: Icons.lock,
          ),
          const Space(
            heightFactor: 6,
          ),
          PrimaryButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final MyUser myUser = MyUser(
                    id: "",
                    fullName: _fullNameController.text,
                    email: _emailController.text);
                context.read<SignUpBloc>().add(SignUpRequired(
                    myUser: myUser, password: _passwordController.text));
              }
            },
            text: AppLanguage.signUp,
          ),
          const Space(
            heightFactor: 2,
          ),
          Text(
            'By continuing, you agree to our Terms of Services and Privacy policy',
            style: GoogleFonts.rubik(color: theme.secondaryText, fontSize: 13),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
