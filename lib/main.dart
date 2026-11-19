import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:responsi/model/recipe.dart';
import 'package:responsi/model/recipe_adapter.dart';
import 'package:responsi/view/controller/favorite_controller.dart';
import 'package:responsi/view/page/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();
    Hive.registerAdapter(RecipeAdapter());
    await Hive.openBox('favorites');
  } catch (e) {
    // Hive initialization may fail on some devices due to platform plugin issues.
    // Favorites will work in memory-only mode for the current session.
  }

  Get.put(FavoriteController());

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
