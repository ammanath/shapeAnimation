import 'package:flutter/material.dart';
import 'package:stars_animate/StarsWidget.dart';
import 'package:stars_animate/bubblesWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stars',
      home: Stars(),
    );
  }
}
