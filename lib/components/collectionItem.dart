import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';

class CollectionItem extends StatelessWidget {
  CollectionItem(this.recipe, this.onSelect, this.onClearSelect);

  final RecipeDTO recipe;
  final Function(RecipeDTO) onSelect;
  final Function onClearSelect;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
        onTap: () {
          onSelect(this.recipe);
        },
        onLongPressEnd: (_) {
          onClearSelect();
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                      color: colorScheme.background,
                      child: FractionallySizedBox(
                          widthFactor: .5,
                          heightFactor: .5,
                          child: CircularProgressIndicator(
                              backgroundColor: colorScheme.background)),
                    ),
                imageUrl: this.recipe.thumbnailUrl)));
  }
}
