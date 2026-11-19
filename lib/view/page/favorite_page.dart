import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:material_ui/material_ui.dart';
import 'package:responsi/view/controller/favorite_controller.dart';
import 'package:responsi/view/page/recipe_detail_page.dart';
import 'package:responsi/view/widget/recipe_card.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final FavoriteController _favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            'Resep favorit',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Obx(() {
          if (_favoriteController.favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada resep favorit',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: _favoriteController.favorites.length,
            itemBuilder: (context, index) {
              final currentRecipe = _favoriteController.favorites[index];
              return RecipeCard(
                currentRecipe,
                onTap: () {
                  Get.to(RecipeDetailPage(currentRecipe));
                },
              );
            },
          );
        }),
      ),
    );
  }
}
