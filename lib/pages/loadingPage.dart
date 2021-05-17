import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage();

  @override
  Widget build(BuildContext context) {
    var localTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
          child: Text(
        "Loading",
        style: localTheme.headline1,
      )),
    );
  }
}
