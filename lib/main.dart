import 'package:flutter/material.dart';
import 'package:pragma_app/src/pages/information_page.dart';
import 'package:pragma_app/src/pages/landing_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
      routes: {'information': (context) => InformationPage()},
    );
  }
}
