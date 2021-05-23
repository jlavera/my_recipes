import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepsItem extends StatelessWidget {
  StepsItem(this.stepNumber, this.step);

  final int stepNumber;
  final String step;

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${stepNumber + 1} Step",
                style: localTheme.headline4,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                this.step,
                style: localTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
