import 'package:flutter/material.dart';
import 'package:innovent_test/UI/landing_page.dart';
import 'package:innovent_test/Utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: LandingPage(),
    );
  }
}
