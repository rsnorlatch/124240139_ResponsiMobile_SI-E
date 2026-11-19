import 'package:hive/hive.dart';
import 'package:responsi/model/recipe.dart';

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    return Recipe(
      id: reader.readInt(),
      name: reader.readString(),
      prepTimeMinutes: reader.readInt(),
      cookTimeMinutes: reader.readInt(),
      serving: reader.readInt(),
      difficulty: reader.readString(),
      cuisine: reader.readString(),
      caloriesPerServing: reader.readInt(),
      rating: reader.read(),
      image: reader.readString(),
      ingredient: reader.readList(),
      instruction: reader.readList(),
      tags: reader.readList(),
      mealType: reader.readList(),
      reviewCount: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeInt(obj.prepTimeMinutes);
    writer.writeInt(obj.cookTimeMinutes);
    writer.writeInt(obj.serving);
    writer.writeString(obj.difficulty);
    writer.writeString(obj.cuisine);
    writer.writeInt(obj.caloriesPerServing);
    writer.write(obj.rating);
    writer.writeString(obj.image);
    writer.writeList(obj.ingredient);
    writer.writeList(obj.instruction);
    writer.writeList(obj.tags);
    writer.writeList(obj.mealType);
    writer.writeInt(obj.reviewCount);
  }
}
