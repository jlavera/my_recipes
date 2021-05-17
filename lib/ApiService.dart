import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';

const apiBaseURL = 'localhost:8080';

class ApiService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<List<RecipeDTO>> getRecipes() {
    return FirebaseFirestore.instance.collection('recipes').get().then(
        (snapshot) =>
            snapshot.docs.map((doc) => RecipeDTO.fromDoc(doc)).toList());
  }
}
