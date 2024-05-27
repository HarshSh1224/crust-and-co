import 'models/food_item_model.dart';

abstract class FoodRepository {
  Future<List<FoodItem>> fetchAllFoodItems();

  List<FoodItem> get allFoodItems;
}
