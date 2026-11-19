import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:material_ui/material_ui.dart';
import 'package:responsi/model/recipe.dart' show Recipe;
import 'package:responsi/view/controller/favorite_controller.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage(this.recipe, {super.key});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<FavoriteController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          actions: [
            GetX<FavoriteController>(
              builder: (_) {
                final isFavorited = favoriteController.isFavorite(recipe);
                return IconButton(
                  onPressed: () {
                    favoriteController.toggleFavorite(recipe);
                    Get.snackbar(
                      isFavorited
                          ? 'Removed from favorites'
                          : 'Added to favorites',
                      recipe.name,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                    );
                  },
                  icon: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: isFavorited ? Colors.red : Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsetsGeometry.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(recipe.image),
              Text(
                recipe.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight(800)),
              ),
              Text(
                "${recipe.cuisine} * ${recipe.mealType.fold("", (previous, current) => previous.isEmpty ? current : '$previous, $current')}",
              ),

              Text(
                "Bahan-bahan: ",
                style: TextStyle(fontWeight: FontWeight(800)),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: recipe.ingredient.length,
                  itemBuilder: (context, index) {
                    return Text("${index + 1}. ${recipe.ingredient[index]}");
                  },
                ),
              ),

              Text(
                "langkah memasak: ",
                style: TextStyle(fontWeight: FontWeight(800)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: recipe.instruction.length,
                  itemBuilder: (context, index) {
                    return Text("${index + 1}. ${recipe.instruction[index]}");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
