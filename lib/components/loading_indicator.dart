import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        )..repeat(),
        curve: Curves.easeInOutCirc,
      )),
      child: Opacity(
        opacity: 0.4,
        child: Image.asset('assets/images/logo.png',))
    );
  }
}