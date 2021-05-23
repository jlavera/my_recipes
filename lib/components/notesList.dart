import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/dtos/recipeDTO.dart';

class NotesList extends StatelessWidget {
  NotesList(this.recipe);

  final RecipeDTO recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        NotesItem(Colors.red, Icons.hourglass_bottom_outlined,
            "${this.recipe.time} Min"),
        NotesItem(Colors.blue, Icons.workspaces_outline,
            this.recipe.difficulty.toUpperCase()),
      ]),
    );
  }
}

class NotesItem extends StatelessWidget {
  NotesItem(this.color, this.icon, this.text);

  final Color color;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          color: this.color.withAlpha(50),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(
                this.icon,
                color: this.color,
              ),
            ),
            Text(
              this.text.toUpperCase(),
              style: localTheme.headline4.copyWith(color: this.color),
            ),
          ],
        ),
      ),
    );
  }
}
