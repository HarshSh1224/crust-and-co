enum FoodType { pizza, drink, extra }

enum PizzaCategory { italian, chicagoStyle, sicilianPizza }

class FoodItem {
  String id;
  FoodType type;
  PizzaCategory? pizzaCategory;
  String title;
  double price;
  String calories;
  String prop1;
  String description;
  String imageUrl;

  FoodItem({
    required this.id,
    required this.type,
    this.pizzaCategory,
    required this.title,
    required this.price,
    required this.calories,
    required this.prop1,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'pizzaCategory': pizzaCategory?.index,
      'title': title,
      'price': price,
      'calories': calories,
      'diameter': prop1,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  static FoodItem fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: "map['id']",
      type: FoodType.values.firstWhere((element) => element.name == map['type'], orElse: () => FoodType.pizza),
      pizzaCategory: map['pizzaCategory'] != null
          ? PizzaCategory.values.firstWhere((element) => element.name == map['pizzaCategory'], orElse: () => PizzaCategory.italian)
          : null,
      title: map['title'],
      price: double.parse(map['price']),
      calories: map['calories'].toString(),
      prop1: map['diameter'].toString(),
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }
}
