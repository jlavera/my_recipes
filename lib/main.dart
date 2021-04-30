import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/collectionPage.dart';

void main() {
  runApp(MyApp());
}

const colorScheme = ColorScheme(
    primary: Color(0xFFFF8C42),
    primaryVariant: Color(0xCCFFFFFF),
    secondary: Color(0xFF794FFF),
    secondaryVariant: Color(0xFFE42C64),
    background: Color(0xFF1B1E21),
    surface: Color(0xFF2F333C),
    error: Color.fromRGBO(255, 0, 0, 1),
    onPrimary: Color(0xFF614AD3),
    onSecondary: Color(0xFFFAFAFA),
    onBackground: Color(0xFF1B1E21),
    onSurface: Color(0xFF2F333C),
    onError: Color.fromRGBO(255, 0, 0, 1),
    brightness: Brightness.dark);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return MaterialApp(
      title: 'My Recipes',
      theme: ThemeData(
        fontFamily: 'Roboto',
        textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: colorScheme.primary),
            headline2: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w200,
                color: colorScheme.primary),
            headline3: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: colorScheme.primary),
            bodyText1: TextStyle(fontSize: 14.0)),
        primaryColor: colorScheme.primary,
        accentColor: colorScheme.secondary,
        backgroundColor: colorScheme.background,
        colorScheme: colorScheme,
      ),
      home: CollectionPage(),
    );
  }
}
