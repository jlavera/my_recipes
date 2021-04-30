import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_recipes/components/collectionItem.dart';
import 'package:my_recipes/components/collectionItemOverlay.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';

import '../ApiService.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List<RecipeDTO> allRecipes = [];
  RecipeDTO selectedRecipe;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  void getRecipes() {
    ApiService.getRecipes().then((recipes) async {
      setState(() {
        this.allRecipes = recipes;
      });
    });
  }

  void clearSelectedRecipe() {
    this.setState(() {
      this.selectedRecipe = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    const lineSize = 10.0;
    const spacing = 4.0;

    return Scaffold(
        backgroundColor: colorScheme.background,
        body: Center(
          child: Stack(children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(spacing, 15, spacing, 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 18,
                      ),
                      child: Text("my recipes", style: localTheme.headline2),
                    ),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: lineSize / 2, bottom: lineSize / 2 + spacing),
                        child: CustomPaint(
                            painter: DrawHorizontalLine(
                                colorScheme.primary, lineSize)),
                      ),
                    ]),
                    GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        mainAxisSpacing: spacing,
                        crossAxisSpacing: spacing,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: this.allRecipes.map((recipe) {
                          return CollectionItem(recipe, (recipe) {
                            this.setState(() {
                              this.selectedRecipe = recipe;
                            });
                          }, () {
                            this.setState(() {
                              this.selectedRecipe = null;
                            });
                          });
                        }).toList())
                  ],
                )),
            this.selectedRecipe != null
                ? CollectionItemOverlay(
                    this.selectedRecipe, clearSelectedRecipe)
                : Container(),
          ]),
        ));
  }
}

class DrawHorizontalLine extends CustomPainter {
  Paint _paint;

  DrawHorizontalLine(Color color, double width) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.square;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(1000, 0), Offset(0, 0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
