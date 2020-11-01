import 'package:flutter/material.dart';
import 'pages/detail_page.dart';
import 'pages/home_page.dart';
import 'pages/loading_page.dart';

void main() {
  runApp(EarthquakesApp());
}

class EarthquakesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: LoadingPage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        LoadingPage.routeName: (context) => LoadingPage(),
        DetailPage.routeName: (context) => DetailPage(),
      },
    );
  }
}
