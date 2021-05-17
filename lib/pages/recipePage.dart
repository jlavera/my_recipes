import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/components/RecipeSection.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipePage extends StatefulWidget {
  RecipePage(this.recipe);

  final RecipeDTO recipe;

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int _current = 0;

  void openSource() async {
    await canLaunch(this.widget.recipe.source)
        ? await launch(this.widget.recipe.source)
        : throw 'Could not launch ${this.widget.recipe.source}';
  }

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            print("setting state");
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
                    Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: this.widget.recipe.fullImageUrls.map((url) {
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
                        )),
                  ],
                ),
              ),
              Text(
                this.widget.recipe.name,
                style: localTheme.headline3,
                textAlign: TextAlign.start,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    this.widget.recipe.author,
                    style: localTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: this.openSource,
                      child: Icon(Icons.input,
                          size: 15, color: colorScheme.primary),
                    ),
                  )
                ],
              ),
              RecipeSection("Ingredients", this.widget.recipe.ingredients),
              RecipeSection("Steps", this.widget.recipe.steps),
            ],
          )
        ],
      ),
    );
  }
}
