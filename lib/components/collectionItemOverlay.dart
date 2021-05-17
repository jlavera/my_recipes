import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';
import 'package:my_recipes/pages/recipePage.dart';
import 'package:url_launcher/url_launcher.dart';

class CollectionItemOverlay extends StatefulWidget {
  CollectionItemOverlay(this.recipe, this.onClearSelect);

  final RecipeDTO recipe;
  final Function onClearSelect;

  @override
  _CollectionItemOverlayState createState() => _CollectionItemOverlayState();
}

class _CollectionItemOverlayState extends State<CollectionItemOverlay> {
  int _current = 0;

  void openSource() async {
    await canLaunch(this.widget.recipe.source)
        ? await launch(this.widget.recipe.source)
        : throw 'Could not launch ${this.widget.recipe.source}';
  }

  void openRecipeDescription(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipePage(this.widget.recipe)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: () async {
        this.widget.onClearSelect();
        return false;
      },
      child: Stack(
        children: [
          GestureDetector(
              onTap: this.widget.onClearSelect,
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
                    padding: const EdgeInsets.only(
                        bottom: 0.0, top: 15.0, left: 15, right: 15),
                    child: Text(
                      this.widget.recipe.name,
                      style: localTheme.headline3,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                                enableInfiniteScroll: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                            items: this
                                .widget
                                .recipe
                                .fullImageUrls
                                .map((item) => Container(
                                      child: Center(
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              imageUrl: item)),
                                    ))
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                this.widget.recipe.fullImageUrls.map((url) {
                              int index =
                                  this.widget.recipe.fullImageUrls.indexOf(url);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? colorScheme.primary
                                      : colorScheme.background,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MenuItem(Icons.grid_on_sharp,
                            f: this.widget.onClearSelect),
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
      ),
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
