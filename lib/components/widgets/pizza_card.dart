import 'package:crust_and_co/blocs/theme_bloc/crust_theme.dart';
import 'package:crust_and_co/blocs/theme_bloc/theme_bloc.dart';
import 'package:crust_and_co/components/widgets/primary_card.dart';
import 'package:crust_and_co/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PizzaCard extends StatelessWidget {
  const PizzaCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CrustTheme theme = BlocProvider.of<ThemeBloc>(context).crustTheme;
    return SizedBox(
      // color: Colors.red,
      width: 220,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: PrimaryCard(
              borderWidth: 2,
              borderRadius: 10,
              width: 150,
              padding: const EdgeInsets.only(left: 17, bottom: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 140,
                  ),
                  Text(
                    'Zesty Zing',
                    style: GoogleFonts.poppins(
                        letterSpacing: -1,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: theme.primaryText),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹ 300',
                    style: GoogleFonts.poppins(
                        letterSpacing: -2,
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                        color: theme.primaryText),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur',
                    style: GoogleFonts.poppins(
                        letterSpacing: -0.3,
                        height: 1.5,
                        color: theme.secondaryText,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 60,
            top: 25,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(-1, 5),
                    color: Colors.black.withOpacity(0.9),
                    spreadRadius: 2)
              ]),
              child: Image.asset(
                Assets.smaplePizzaRound,
                height: 150,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                  size: 23,
                )),
          )
        ],
      ),
    );
  }
}
