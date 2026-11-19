import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:material_ui/material_ui.dart';
import 'package:responsi/service/recipe_service.dart';
import 'package:responsi/view/controller/login_controller.dart';
import 'package:responsi/view/controller/recipe_controller.dart';
import 'package:responsi/view/page/favorite_page.dart';
import 'package:responsi/view/page/login_page.dart';
import 'package:responsi/view/page/recipe_detail_page.dart';
import 'package:responsi/view/widget/recipe_card.dart';

class RecipePage extends StatelessWidget {
  RecipePage({super.key});

  final recipeController = Get.put(RecipeController());

  final LoginController _loginController = Get.isRegistered<LoginController>()
      ? Get.find<LoginController>()
      : Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await _loginController.logout();
              Get.offAll(() => const LoginPage());
            },
          ),
          title: Text("Halo Faris", style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.white),
              onPressed: () {
                Get.to(() => FavoritePage());
              },
            ),
          ],
        ),
        body: Obx(() {
          if (recipeController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          if (recipeController.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(recipeController.error),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      recipeController.fetchRecipes();
                    },
                    child: const Text('Retry'),
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
            itemCount: recipeController.recipes.length,
            itemBuilder: (context, index) {
              final currentRecipe = recipeController.recipes[index];
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
