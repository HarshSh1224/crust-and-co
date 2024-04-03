import 'package:crust_and_co/constants/assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff15181D),
      body: Center(
        child: Image.asset(Assets.appLogo,
            height: screenHeight * 0.15, width: screenHeight * 0.15),
      ),
    );
  }
}
