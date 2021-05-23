import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/components/ingredientsItem.dart';
import 'package:my_recipes/dtos/ingredientDTO.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';

class IngredientsList extends StatefulWidget {
  IngredientsList(this.recipe);

  final RecipeDTO recipe;

  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  Map<IngredientDTO, bool> hasIngredientMap;

  @override
  void initState() {
    super.initState();
    this.setState(() {
      hasIngredientMap = Map.fromEntries(
          this.widget.recipe.ingredients.map((e) => MapEntry(e, false)));
    });
  }

  void toggleIngredient(IngredientDTO ingredient) {
    this.setState(() {
      hasIngredientMap.update(
          ingredient, (value) => !hasIngredientMap[ingredient]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: this
            .widget
            .recipe
            .ingredients
            .map((ing) => new IngredientsItem(
                ing,
                () => this.toggleIngredient(ing),
                this.hasIngredientMap.containsKey(ing) &&
                    this.hasIngredientMap[ing]))
            .toList(),
      ),
    );
  }
}
