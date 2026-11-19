import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:responsi/model/recipe.dart';

class RecipeCard extends StatelessWidget {
  const new(this.recipe, {required this.onTap, super.key});

  final Recipe recipe;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            recipe.image == ""
                ? const Placeholder()
                : Image.network(recipe.image, width: 100, height: 100),

            Text(recipe.name),

            Row(
              children: [
                Text("${recipe.cuisine} * "),
                Text(recipe.rating.toString()),
                const Icon(Icons.star),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
