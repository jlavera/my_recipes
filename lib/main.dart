import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_recipes/pages/loadingPage.dart';

import 'pages/collectionPage.dart';

void main() {
  runApp(MyApp());
}

const colorScheme = ColorScheme(
    primary: Color(0xFFFF8C42),
    primaryVariant: Color(0xCCFFFFFF),
    secondary: Color(0xFF794FFF),
    secondaryVariant: Color(0xFFE42C64),
    background: Colors.white,
    surface: Color(0xFF2F333C),
    error: Color.fromRGBO(255, 0, 0, 1),
    onPrimary: Color(0xFF614AD3),
    onSecondary: Color(0xFFFAFAFA),
    onBackground: Color(0xFF1B1E21),
    onSurface: Color(0xFF2F333C),
    onError: Color.fromRGBO(255, 0, 0, 1),
    brightness: Brightness.dark);

class MyApp extends StatelessWidget {
  Widget buildAppContainer(Widget child) {
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
            headline4: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary),
            subtitle1: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
            subtitle2: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w300, color: Colors.grey),
            bodyText1: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Colors.black54)),
        primaryColor: colorScheme.primary,
        accentColor: colorScheme.secondary,
        backgroundColor: colorScheme.background,
        colorScheme: colorScheme,
      ),
      home: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return buildAppContainer(
                Text("Error: ${snapshot.error.toString()}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return buildAppContainer(CollectionPage());
          }

          return buildAppContainer(LoadingPage());
        });
  }
}
