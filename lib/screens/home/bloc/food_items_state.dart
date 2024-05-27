part of 'food_items_bloc.dart';

abstract class FoodItemsState extends Equatable {
  const FoodItemsState();
  
  @override
  List<Object> get props => [];
}

class FoodItemsInitialState extends FoodItemsState {}

class FoodItemsLoadedState extends FoodItemsState {
  final List<FoodItem> foodItems;

  const FoodItemsLoadedState({
    required this.foodItems,
  });
}
