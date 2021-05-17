import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/components/tagsItem.dart';

class TagsList extends StatelessWidget {
  TagsList(this.tags, this.onToggleSelectTag, this.selectedTags);

  final List<String> tags;
  final Function onToggleSelectTag;
  final List<String> selectedTags;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: this
                .tags
                .map((t) => TagItem(t, () => this.onToggleSelectTag(t),
                    this.selectedTags.contains(t)))
                .toList() +
            [],
      ),
    );
  }
}
