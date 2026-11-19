class Recipe {
  const Recipe({
    required this.id,
    required this.name,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.serving,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.ingredient,
    required this.instruction,
    required this.rating,
    required this.tags,
    required this.image,
    required this.mealType,
    required this.reviewCount,
  });

  final int id;
  final String name;
  final List<dynamic> ingredient;
  final List<dynamic> instruction;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int serving;
  final String difficulty;
  final String cuisine;
  final int caloriesPerServing;
  final dynamic rating;
  final String image;
  final List<dynamic> tags;
  final List<dynamic> mealType;
  final int reviewCount;

  factory Recipe.fromJson(Map<String, dynamic> parsedJson) {
    return Recipe(
      id: parsedJson["id"],
      name: parsedJson["name"],
      ingredient: parsedJson["ingredients"],
      instruction: parsedJson["instructions"],
      prepTimeMinutes: parsedJson["prepTimeMinutes"],
      cookTimeMinutes: parsedJson["cookTimeMinutes"],
      serving: parsedJson["servings"],
      difficulty: parsedJson["difficulty"],
      cuisine: parsedJson["cuisine"],
      caloriesPerServing: parsedJson["caloriesPerServing"],
      rating: parsedJson["rating"],
      image: parsedJson["image"],
      mealType: parsedJson["mealType"],
      tags: parsedJson["tags"],
      reviewCount: parsedJson["reviewCount"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ingredient': ingredient,
      'instruction': instruction,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'serving': serving,
      'difficulty': difficulty,
      'cuisine': cuisine,
      'caloriesPerServing': caloriesPerServing,
      'rating': rating,
      'image': image,
      'tags': tags,
      'mealType': mealType,
      'reviewCount': reviewCount,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int,
      name: map['name'] as String,
      ingredient: List<dynamic>.from(map['ingredient']),
      instruction: List<dynamic>.from(map['instruction']),
      prepTimeMinutes: map['prepTimeMinutes'] as int,
      cookTimeMinutes: map['cookTimeMinutes'] as int,
      serving: map['serving'] as int,
      difficulty: map['difficulty'] as String,
      cuisine: map['cuisine'] as String,
      caloriesPerServing: map['caloriesPerServing'] as int,
      rating: map['rating'],
      image: map['image'] as String,
      tags: List<dynamic>.from(map['tags']),
      mealType: List<dynamic>.from(map['mealType']),
      reviewCount: map['reviewCount'] as int,
    );
  }
}
