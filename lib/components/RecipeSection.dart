import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeSection extends StatelessWidget {
  RecipeSection(this.title, this.list);

  final String title;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(this.title, style: localTheme.headline3),
                )
              ] +
              this
                  .list
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          e,
                          textAlign: TextAlign.start,
                          style: localTheme.bodyText1,
                        ),
                      ))
                  .toList(),
        ),
      ),
    );
  }
}
