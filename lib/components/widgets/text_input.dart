import 'package:crust_and_co/blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {this.controller, this.hintText, this.obscureText, super.key});
  final String? hintText;
  final TextEditingController? controller;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = BlocProvider.of<ThemeBloc>(context).crustTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
        color: theme.card,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              blurRadius: 13,
              offset: const Offset(1, 5),
              color: Colors.black.withOpacity(0.9),
              spreadRadius: 2)
        ],
        border: Border.all(
          color: theme.cardStroke,
          width: 2,
        ),
      ),
      child: Center(
        child: TextFormField(
          obscureText: obscureText ?? false,
          controller: controller,
          style: GoogleFonts.poppins(fontSize: 17, color: theme.secondaryText),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            border: InputBorder.none,
            hintStyle:
                GoogleFonts.poppins(fontSize: 17, color: theme.secondaryText),
          ),
        ),
      ),
    );
  }
}
