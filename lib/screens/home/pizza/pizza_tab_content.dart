import 'package:crust_and_co/blocs/theme_bloc/crust_theme.dart';
import 'package:crust_and_co/blocs/theme_bloc/theme_bloc.dart';
import 'package:crust_and_co/components/widgets/pizza_card.dart';
import 'package:crust_and_co/components/widgets/primary_card.dart';
import 'package:crust_and_co/components/widgets/space.dart';
import 'package:crust_and_co/constants/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PizzaTabContent extends StatelessWidget {
  const PizzaTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [ItalianPizzas(), ChicagoStylePizzas(), SicilianPizza()],
      ),
    );
  }
}

class ItalianPizzas extends StatelessWidget {
  const ItalianPizzas({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = BlocProvider.of<ThemeBloc>(context).crustTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          const Space(widthFactor: 3),
          Text(
            'Italian',
            style: GoogleFonts.monda(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
        ],
      ),
      const Space(heightFactor: 1),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (170 * 3) + 50,
                height: MediaQuery.of(context).size.height * 0.37,
                child: const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Positioned(left: 680, child: PizzaCard()),
                        // Positioned(left: 510, child: PizzaCard()),
                        Positioned(left: 340, child: PizzaCard()),
                        Positioned(left: 170, child: PizzaCard()),
                        Positioned(left: 0, child: PizzaCard()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ))
    ]);
  }
}

class ChicagoStylePizzas extends StatelessWidget {
  const ChicagoStylePizzas({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = BlocProvider.of<ThemeBloc>(context).crustTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          const Space(widthFactor: 3),
          Text(
            'Chicago Style',
            style: GoogleFonts.monda(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
        ],
      ),
      const Space(heightFactor: 1),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (170 * 3) + 50,
                height: MediaQuery.of(context).size.height * 0.37,
                child: const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Positioned(left: 680, child: PizzaCard()),
                        // Positioned(left: 510, child: PizzaCard()),
                        Positioned(left: 340, child: PizzaCard()),
                        Positioned(left: 170, child: PizzaCard()),
                        Positioned(left: 0, child: PizzaCard()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ))
    ]);
  }
}

class SicilianPizza extends StatelessWidget {
  const SicilianPizza({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = BlocProvider.of<ThemeBloc>(context).crustTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          const Space(widthFactor: 3),
          Text(
            'Sicilian',
            style: GoogleFonts.monda(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
        ],
      ),
      const Space(heightFactor: 1),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: (170 * 3) + 50,
          height: MediaQuery.of(context).size.height * 0.37,
          child: const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Positioned(left: 680, child: PizzaCard()),
                  // Positioned(left: 510, child: PizzaCard()),
                  Positioned(left: 340, child: PizzaCard()),
                  Positioned(left: 170, child: PizzaCard()),
                  Positioned(left: 0, child: PizzaCard()),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
