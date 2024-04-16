enum FoodType { pizza, drink, extra }

enum PizzaCategory { italian, chicagoStyle, sicilianPizza }

class FoodItem {
  String id;
  FoodType type;
  PizzaCategory? pizzaCategory;
  String title;
  double price;
  int calories;
  int diameter;
  String description;
  String imageUrl;

  FoodItem({
    required this.id,
    required this.type,
    this.pizzaCategory,
    required this.title,
    required this.price,
    required this.calories,
    required this.diameter,
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
      'diameter': diameter,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  static FoodItem fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'],
      type: FoodType.values[map['type']],
      pizzaCategory: map['pizzaCategory'] != null
          ? PizzaCategory.values[map['pizzaCategory']]
          : null,
      title: map['title'],
      price: map['price'].toDouble(),
      calories: map['calories'],
      diameter: map['diameter'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }
}
