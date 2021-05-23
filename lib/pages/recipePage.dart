import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/components/ingredientsList.dart';
import 'package:my_recipes/components/notesList.dart';
import 'package:my_recipes/components/recipeImages.dart';
import 'package:my_recipes/components/stepsList.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipePage extends StatefulWidget {
  RecipePage(this.recipe);

  final RecipeDTO recipe;

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  void openSource() async {
    await canLaunch(this.widget.recipe.source)
        ? await launch(this.widget.recipe.source)
        : throw 'Could not launch ${this.widget.recipe.source}';
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> tabsMap = {
      "Ingredients": IngredientsList(widget.recipe),
      "Steps": StepsList(this.widget.recipe.steps)
    };

    var localTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: colorScheme.background,
        body: Container(
          child: Column(
            children: [
              RecipeImages(this.widget.recipe),
              Text(
                this.widget.recipe.name,
                style: localTheme.headline3,
                textAlign: TextAlign.center,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  this.widget.recipe.author,
                  style: localTheme.subtitle2,
                  textAlign: TextAlign.start,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: this.openSource,
                    child:
                        Icon(Icons.input, size: 15, color: colorScheme.primary),
                  ),
                )
              ]),
              NotesList(this.widget.recipe),
              TabBar(
                controller: _tabController,
                indicatorColor: colorScheme.primary,
                labelPadding: EdgeInsets.only(top: 10, bottom: 10),
                tabs: tabsMap.keys
                    .map((t) => Text(
                          t,
                          style: localTheme.subtitle2,
                        ))
                    .toList(),
              ),
              Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: tabsMap.values
                          .map((w) => ListView(children: [w]))
                          .toList()))
            ],
          ),
        ));
  }
}
