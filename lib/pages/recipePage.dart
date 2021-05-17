import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/components/IngredientsList.dart';
import 'package:my_recipes/components/stepsList.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';

class RecipePage extends StatelessWidget {
  RecipePage(this.recipe);

  final RecipeDTO recipe;

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Column(
              children: [
                Text(this.recipe.name, style: localTheme.headline1),
                IngredientsList(this.recipe),
                StepsList(this.recipe),
              ],
            )
          ],
        ),
      ),
    );
  }
}
