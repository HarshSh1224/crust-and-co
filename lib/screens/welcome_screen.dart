import 'package:crust_and_co/blocs/theme_bloc/theme_bloc.dart';
import 'package:crust_and_co/components/widgets/primary_button.dart';
import 'package:crust_and_co/components/widgets/space.dart';
import 'package:crust_and_co/constants/app_language.dart';
import 'package:crust_and_co/constants/assets.dart';
import 'package:crust_and_co/screens/auth/ui/signin_screen.dart';
import 'package:crust_and_co/screens/auth/ui/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen(this.userRepository, {super.key});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    final theme = BlocProvider.of<ThemeBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _bgImage(context),
          _body(context, theme),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, ThemeBloc theme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Assets.appLogoText,
              height: 40,
            ),
            const Spacer(),
            Text(
              AppLanguage.goodCrust,
              style: GoogleFonts.poppins(fontSize: 40, color: Colors.white),
            ),
            Text(
              AppLanguage.tastyPizza,
              style: GoogleFonts.poppins(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
            const Space(),
            const Space(),
            Row(
              children: [
                Expanded(
                    child: PrimaryButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SigninScreen(userRepository)));
                        },
                        text: AppLanguage.signIn)),
              ],
            ),
            const Space(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignupScreen(userRepository)));
                },
                child: const Text(AppLanguage.signUp)),
            const Space(),
            ElevatedButton(
                onPressed: () {
                  context.read<ThemeBloc>().add(ThemeChanged(
                      theme.themeType == ThemeType.dark
                          ? ThemeType.light
                          : ThemeType.dark));
                },
                child: const Text('Theme')),
          ],
        ),
      ),
    );
  }

  SizedBox _bgImage(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        Assets.welcomeBgImage,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
