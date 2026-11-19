import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:responsi/model/recipe.dart';
import 'package:responsi/service/recipe_service.dart';

class RecipeController extends GetxController {
  final service = RecipeService();

  final RxList<Recipe> _recipes = <Recipe>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  @override
  void onInit() {
    fetchRecipes();
    super.onInit();
  }

  Future<void> fetchRecipes() async {
    _isLoading.value = true;
    _error.value = '';
    try {
      final data = await service.fetchRecipes();
      _recipes.assignAll(data);
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}
