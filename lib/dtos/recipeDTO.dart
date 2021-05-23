import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_recipes/dtos/ingredientDTO.dart';

class RecipeDTO {
  RecipeDTO(this.name, this.source, this.author, this.imageIds, this.tags,
      this.ingredients, this.steps);

  final String name;
  final String source;
  final String author;
  final List<String> imageIds;
  final List<String> tags;
  final List<IngredientDTO> ingredients;
  final List<String> steps;

  String getFullImageUrl(String imageId) =>
      "https://firebasestorage.googleapis.com/v0/b/my-recipes-312600.appspot.com/o/$imageId?alt=media";

  String get thumbnailUrl {
    return getFullImageUrl(imageIds.first); // TODO add tn
  }

  List<String> get fullImageUrls {
    return imageIds.map((imageId) => getFullImageUrl(imageId)).toList();
  }

  static RecipeDTO fromDoc(DocumentSnapshot doc) {
    var data = doc.data();

    T getField<T>(String key, T def) {
      return data.containsKey(key) ? data[key] : def;
    }

    List<IngredientDTO> getIngredients() {
      return (data['ingrs'] as List)
          .map((ing) => IngredientDTO.fromJson(ing))
          .toList();
    }

    return RecipeDTO(
      getField("name", ""),
      getField("source", ""),
      getField("author", ""),
      List.from(getField("imageIds", <String>[])),
      List.from(getField("tags", <String>[])),
      getIngredients(),
      List.from(getField("steps", <String>[])),
    );
  }
}
