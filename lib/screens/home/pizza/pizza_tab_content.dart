import 'package:crust_and_co/blocs/theme_bloc/crust_theme.dart';
import 'package:crust_and_co/blocs/theme_bloc/theme_bloc.dart';
import 'package:crust_and_co/components/widgets/loading_indicator.dart';
import 'package:crust_and_co/components/widgets/food_item_card.dart';
import 'package:crust_and_co/components/widgets/primary_card.dart';
import 'package:crust_and_co/components/widgets/space.dart';
import 'package:crust_and_co/constants/assets.dart';
import 'package:crust_and_co/screens/home/bloc/food_items_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_repository/food_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class PizzaTabContent extends StatelessWidget {
  const PizzaTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: BlocBuilder<FoodItemsBloc, FoodItemsState>(
        builder: (context, state) {
          if(state is FoodItemsInitialState) return const LoadingIndicator();

          if(state is FoodItemsLoadedState) {
          
            final italianPizzas = state.foodItems.where((element) => element.pizzaCategory == PizzaCategory.italian).toList();
            final chicagoPizzas = state.foodItems.where((element) => element.pizzaCategory == PizzaCategory.chicagoStyle).toList();
            final sciilianPizzas = state.foodItems.where((element) => element.pizzaCategory == PizzaCategory.sicilianPizza).toList();

            return Column(
              children: [
                ItalianPizzas(italianPizzas), 
                const Space(heightFactor: 3,),
                ChicagoStylePizzas(chicagoPizzas), 
                const Space(heightFactor: 3,),
                SicilianPizza(sciilianPizzas)],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ItalianPizzas extends StatelessWidget {
  ItalianPizzas(this.pizzas, {super.key});

  List<FoodItem> pizzas;

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
                width: (170 * pizzas.length) + 50,
                height: MediaQuery.of(context).size.height * 0.37,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        for(int i = pizzas.length - 1; i >= 0; i--) 
                          Positioned(left: 170.0 * i, child: FoodItemCard(pizzas[i])),
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
  ChicagoStylePizzas(this.pizzas, {super.key});

  List<FoodItem> pizzas;

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
                width: (170 * pizzas.length) + 50,
                height: MediaQuery.of(context).size.height * 0.37,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        for(int i = pizzas.length - 1; i >= 0; i--) 
                          Positioned(left: 170.0 * i, child: FoodItemCard(pizzas[i])),
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
  SicilianPizza(this.pizzas, {super.key});

  List<FoodItem> pizzas;

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
          width: (170 * pizzas.length) + 50,
          height: MediaQuery.of(context).size.height * 0.37,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for(int i = pizzas.length - 1; i >= 0; i--) 
                    Positioned(left: 170.0 * i, child: FoodItemCard(pizzas[i])),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
