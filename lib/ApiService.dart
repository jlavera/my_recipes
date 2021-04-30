import 'package:my_recipes/dtos/recipeDTO.dart';

const apiBaseURL = 'localhost:8080';

class ApiService {
  static Future<List<RecipeDTO>> getRecipes() {
    // return http.get('$apiBaseURL/cards').then((value) {
    //   var json = jsonDecode(value.body.toString()) as List;
    //
    //   return json.map((item) => ACard.fromJson(item)).toList();
    // });

    return Future.value([
      RecipeDTO(
          "Huevos revueltos",
          "https://www.youtube.com/watch?v=CXTnq7srJRs",
          "https://i.imgur.com/SFMNuN9.png",
          "https://i.imgur.com/SFMNuN9.png", [
        "Huevos",
        "Vegetariano"
      ], [
        "2 teaspoons potato starch, tapioca starch or cornstarch",
        "4 tablespoons cold unsalted butter, cut into 1/4-inch cubes",
        "4 eggs (see Note)",
        "Pinch of kosher salt",
      ], [
        "In a medium bowl, whisk together starch with 1 1/2 tablespoons water until no lumps remain. Add half the butter cubes to starch mixture. Add eggs and salt, and whisk, breaking up any cubes of butter that have stuck together, until the eggs are frothy and homogenous. (There will still be solid chunks of butter in the eggs.)",
        "Set your serving plate near the stovetop. Heat 1 tablespoon water in a 10-inch nonstick skillet over medium-high, swirling gently until the water evaporates, leaving behind only a few small droplets. Immediately add the remaining 2 tablespoons butter and swirl vigorously until the butter is mostly melted and foamy but not brown, about 10 seconds.",
        "Immediately add the egg mixture and cook, pushing and folding the eggs with a spatula, until they are slightly less cooked than you’d like them, about 1 to 2 minutes, depending on doneness. More vigorous stirring will result in finer, softer curds, while more leisurely stirring will result in larger, fluffier curds. Immediately transfer to the serving plate, and serve.",
        "If cooking fewer eggs or more, adjust pan size accordingly, and note that cooking time in Step 3 can vary significantly, needing as little as 15 to 30 seconds for 2 eggs, or as long as 3 to 4 minutes for 8 eggs",
      ]),
      RecipeDTO(
          "Riñoncitos al verdeo",
          "https://www.youtube.com/watch?v=Ioha78_dtds",
          "https://i.imgur.com/2XELxO6.png",
          "https://i.imgur.com/2XELxO6.png", [
        "Carne"
      ], [
        "1kg de riñón limpio.",
        "2 cebollas de verdeo cortadas y separadas lo blanco de lo verde.",
        "2 dientes de ajo picados.",
        "2 limas caipirinha.",
        "100 cc de vino blanco,",
        "200 g de crema de leche,",
        "100 g de manteca fría en cubos,",
        "2 cdas de ciboulette fresco picado.",
        "Una cdta de almidón de maíz.",
        "Aceite de oliva, c/n.",
        "Sal y pimienta, a gusto.",
      ], [
        "Porcionar los riñones y reservar.",
        "Colocar una olla al fuego bien fuerte, agregar manteca y aceite de oliva y dorar bien los riñones sin mover para que no se hiervan.",
        "Agregar el verdeo, el ajo, salpimentar y mover un poquito.",
        "Deglasar con el vino blanco, cocinar por unos segundos hasta que evapore el alcohol.",
        "Luego agregar la crema y la ralladura de las limas, agregar el almidón y cocinar hasta que tome consistencia cremosa.",
      ]),
    ].toList());
  }
}
