import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';

class IngredientsList extends StatelessWidget {
  IngredientsList(this.recipe);

  final RecipeDTO recipe;

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("ingredients", style: localTheme.headline3),
              )
            ] +
            this
                .recipe
                .ingredients
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e,
                        textAlign: TextAlign.justify,
                      ),
                    ))
                .toList(),
      ),
    );
  }
}
