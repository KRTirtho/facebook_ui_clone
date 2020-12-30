import 'fixed_components/Toolbar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'facebook',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MainCollapsingToolbarBody(),
        backgroundColor: Colors.grey[350],
      ),
      theme: ThemeData(
        accentColor: Colors.blue[600],
        accentIconTheme: IconThemeData(size: 13, color: Colors.grey[800]),
        accentTextTheme: TextTheme(),
        appBarTheme: AppBarTheme(),
        backgroundColor: Colors.white,
        buttonColor: Colors.grey[200],
        primaryColor: Colors.blue[600],
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              overlayColor: MaterialStateProperty.all<Color>(Colors.black12)),
        ),
      ),
    );
  }
}
