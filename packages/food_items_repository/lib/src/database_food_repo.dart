import 'package:food_repository/src/api/api.dart';
import 'package:food_repository/src/api/api_routes.dart';
import 'package:food_repository/src/constants/repo_constants.dart';
import 'package:food_repository/src/food_repo.dart';
import 'package:food_repository/src/models/food_item_model.dart';

class DatabaseFoodRepo implements FoodRepository{
  final _api = Api();

  List<FoodItem> _allFoodItems = [];

  @override
  Future<List<FoodItem>> fetchAllFoodItems() async {
    final res = await _api.sendRequest.get(ApiRoutes.allFoodItems);
    final List foodObjectsList = res.data[RepoConstants.data];

    return _allFoodItems = foodObjectsList.map((map) => FoodItem.fromMap(map)).toList();
  }

  @override
  List<FoodItem> get allFoodItems => _allFoodItems;
}