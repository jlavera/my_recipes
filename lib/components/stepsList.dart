import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/components/stepsItem.dart';

class StepsList extends StatelessWidget {
  StepsList(this.list);

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this
            .list
            .asMap()
            .entries
            .map((e) => StepsItem(e.key, e.value))
            .toList(),
      ),
    );
  }
}
