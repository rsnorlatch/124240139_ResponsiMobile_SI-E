import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:responsi/model/recipe.dart';

class RecipeService {
  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse("https://dummyjson.com/recipes"));

    if (response.statusCode != 200) {
      throw Exception('Failed to load recipes: ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final recipes = decoded["recipes"];
    if (recipes == null || recipes is! List) {
      throw Exception('Unexpected response format: missing "recipes" list');
    }

    return recipes
        .map((item) => item as Map<String, dynamic>)
        .map((item) => Recipe.fromJson(item))
        .toList();
  }
}
