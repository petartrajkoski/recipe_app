class IngredientItem {
  final String name;

  IngredientItem({required this.name});
}

class MealDetail {
  final String id;
  final String name;
  final String instructions;
  final List<IngredientItem> ingredients;
  final String ytLink;

  MealDetail({
    required this.id,
    required this.name,
    required this.instructions,
    required this.ingredients,
    required this.ytLink,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json){
    final List<IngredientItem> ingredients = [];

    for(var i = 1; i <= 20; i++){
      final ingNum = 'strIngredient\$i';
      final ing = (json[ingNum] ?? '').toString().trim();
      if(ing.isNotEmpty){
        if(ing.toLowerCase() != 'null'){
          ingredients.add(IngredientItem(name: ing));
        }
      }
    }

    return MealDetail(
      id: json['idMeal']?.toString() ?? '',
      name: json['strMeal']?.toString() ?? '',
      instructions: json['strInstructions']?.toString() ?? '',
      ingredients: ingredients,
      ytLink: json['strYoutube']?.toString() ?? '',
    );
  }
}