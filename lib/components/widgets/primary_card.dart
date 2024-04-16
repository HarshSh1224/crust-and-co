import 'package:crust_and_co/blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    this.child,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    super.key,
  });
  final Widget? child;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = BlocProvider.of<ThemeBloc>(context).crustTheme;
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: theme.card,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        boxShadow: [
          BoxShadow(
              blurRadius: 15,
              offset: const Offset(1, 5),
              color: Colors.black.withOpacity(0.9),
              spreadRadius: 2)
        ],
        border: Border.all(
          color: theme.cardStroke,
          width: borderWidth ?? 2,
        ),
      ),
      child: child,
    );
  }
}
