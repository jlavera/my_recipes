import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';
import 'package:my_recipes/pages/recipePage.dart';
import 'package:url_launcher/url_launcher.dart';

class CollectionItemOverlay extends StatelessWidget {
  CollectionItemOverlay(this.recipe, this.onClearSelect);

  final RecipeDTO recipe;
  final Function onClearSelect;

  void openSource() async {
    await canLaunch(this.recipe.source)
        ? await launch(this.recipe.source)
        : throw 'Could not launch ${this.recipe.source}';
  }

  void openRecipeDescription(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipePage(this.recipe)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        GestureDetector(
            onTap: this.onClearSelect,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                decoration: new BoxDecoration(
                    color: colorScheme.background.withOpacity(.5)),
              ),
            )),
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            width: MediaQuery.of(context).size.width * .9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                  child: Text(
                    this.recipe.name,
                    style: localTheme.headline3,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          imageUrl: this.recipe.fullImageUrl),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MenuItem(Icons.grid_on_sharp, f: this.onClearSelect),
                      MenuItem(Icons.article_outlined, f: () {
                        openRecipeDescription(context);
                      }),
                      MenuItem(Icons.open_in_browser, f: this.openSource)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  MenuItem(this.icon, {this.f});

  final IconData icon;
  final Function f;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: this.f,
      child: Icon(this.icon, color: colorScheme.primary),
    );
  }
}
