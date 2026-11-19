import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:responsi/model/recipe.dart';
import 'package:responsi/model/recipe_adapter.dart';

class FavoriteController extends GetxController {
  static const String _boxName = 'favorites';
  Box? _box;
  bool get isHiveAvailable => _box != null;

  final RxList<Recipe> _favorites = <Recipe>[].obs;
  List<Recipe> get favorites => _favorites;

  @override
  void onInit() {
    _box = _tryOpenBox();
    loadFavorites();
    super.onInit();
  }

  Box? _tryOpenBox() {
    try {
      return Hive.box(_boxName);
    } catch (_) {
      return null;
    }
  }

  Future<void> loadFavorites() async {
    if (_box == null) return;
    final ids = List<int>.from(_box!.get('favoriteIds', defaultValue: <int>[]));
    _favorites.assignAll(
      ids.where((id) => _box!.containsKey(id)).map((id) {
        final data = _box!.get(id) as Map;
        return Recipe.fromMap(Map<String, dynamic>.from(data));
      }).toList(),
    );
  }

  bool isFavorite(Recipe recipe) {
    return _favorites.any((r) => r.id == recipe.id);
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    if (isFavorite(recipe)) {
      _favorites.removeWhere((r) => r.id == recipe.id);
      if (_box != null) {
        await _box!.delete(recipe.id);
      }
    } else {
      _favorites.add(recipe);
      if (_box != null) {
        await _box!.put(recipe.id, recipe.toMap());
      }
    }

    if (_box != null) {
      await _box!.put('favoriteIds', _favorites.map((r) => r.id).toList());
    }
    update();
  }
}
