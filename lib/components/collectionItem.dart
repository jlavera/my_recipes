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
    final localTheme = Theme.of(context).textTheme;

    return GestureDetector(
        onTap: () {
          onSelect(this.recipe);
        },
        onLongPressEnd: (_) => onClearSelect(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                  decoration: BoxDecoration(
                      // color: colorScheme.background,
                      // borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                            height: 70,
                            color: colorScheme.background,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 60, right: 60, top: 10, bottom: 10),
                              child: CircularProgressIndicator(
                                  backgroundColor: colorScheme.background),
                            ),
                          ),
                      imageUrl: this.recipe.thumbnailUrl)),
            ),
            Container(
                child: Text(
              this.recipe.name,
              style: localTheme.headline4,
              textAlign: TextAlign.center,
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  child: Text(
                this.recipe.author,
                style: localTheme.subtitle1,
                textAlign: TextAlign.start,
              )),
            )
          ],
        ));
  }
}
