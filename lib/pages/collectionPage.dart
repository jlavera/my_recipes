import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_recipes/components/collectionItem.dart';
import 'package:my_recipes/components/tagsList.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';
import 'package:my_recipes/pages/recipePage.dart';

import '../ApiService.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List<RecipeDTO> allRecipes = [];
  Set<String> selectedTags = Set.identity();
  Set<String> allTags = Set.identity();

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  void getRecipes() {
    ApiService.getRecipes().then((recipes) async {
      setState(() {
        this.allRecipes = recipes;
        this.allTags = this.allRecipes.isEmpty
            ? List.empty()
            : this
                .allRecipes
                .map((e) => e.tags.map((t) => t.toUpperCase()).toList())
                .reduce((value, element) => value + element)
                .toSet();
      });
    });
  }

  void toggleSelectTag(String tag) {
    if (selectedTags.contains(tag)) {
      this.setState(() {
        selectedTags.remove(tag);
      });
    } else {
      this.setState(() {
        selectedTags.add(tag);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    const lineSize = 5.0;
    const spacing = 4.0;

    var showingRecipes = this.selectedTags.isEmpty
        ? this.allRecipes
        : this
            .allRecipes
            .where((recipe) => recipe.tags.any((recipeTag) => this
                .selectedTags
                .any((selectedTag) => selectedTag == recipeTag.toUpperCase())))
            .toList();

    return Scaffold(
        backgroundColor: colorScheme.background,
        body: Center(
          child: Padding(
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
                          top: lineSize / 2, bottom: lineSize / 2),
                      child: CustomPaint(
                          painter: DrawHorizontalLine(
                              colorScheme.primary, lineSize)),
                    ),
                  ]),
                  TagsList(
                      this.allTags.toList(),
                      (String r) => toggleSelectTag(r),
                      this.selectedTags.toList()),
                  new Expanded(
                      child: new ListView(shrinkWrap: true, children: [
                    StaggeredGridView.countBuilder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      itemCount: showingRecipes.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                              child: CollectionItem(showingRecipes[index],
                                  (recipe) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecipePage(recipe)),
                        );
                      })),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(2),
                      mainAxisSpacing: spacing,
                      crossAxisSpacing: spacing,
                    )
                  ]))
                ],
              )),
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
