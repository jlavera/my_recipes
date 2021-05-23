import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';

class RecipeImages extends StatefulWidget {
  const RecipeImages(this.recipe);

  final RecipeDTO recipe;

  @override
  _RecipeImagesState createState() => _RecipeImagesState();
}

class _RecipeImagesState extends State<RecipeImages> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
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
          Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: this.widget.recipe.fullImageUrls.map((url) {
                  int index = this.widget.recipe.fullImageUrls.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: this._current == index
                          ? colorScheme.primary
                          : colorScheme.background,
                    ),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }
}
