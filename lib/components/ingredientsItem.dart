import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/dtos/ingredientDTO.dart';

class IngredientsItem extends StatelessWidget {
  IngredientsItem(this.ingredient, this.toggleIngredient, this.toggled);

  final IngredientDTO ingredient;
  final Function toggleIngredient;
  final bool toggled;

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;
    var localScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
      child: GestureDetector(
        onTap: () => toggleIngredient(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 35,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  this.toggled
                      ? Icons.check
                      : Icons.check_box_outline_blank_outlined,
                  color: localScheme.primary,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 60 - 16 - 35,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.ingredient.description,
                  style: localTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  this.ingredient.quantity,
                  style: localTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  this.ingredient.cleanUnit,
                  style: localTheme.bodyText1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
