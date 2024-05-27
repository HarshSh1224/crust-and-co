import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_repository/food_repository.dart';

part 'food_items_event.dart';
part 'food_items_state.dart';

class FoodItemsBloc extends Bloc<FoodItemsEvent, FoodItemsState> {

  final FoodRepository foodRepository;

  FoodItemsBloc(this.foodRepository) : super(FoodItemsInitialState()) {
    foodRepository.fetchAllFoodItems().then((allItems) {
      emit(FoodItemsLoadedState(foodItems: allItems));
    });
  }
}
