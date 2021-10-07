import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vastum/menu.dart';
import 'package:vastum/search.dart';
import 'loading_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/mainmenu': (context) => MainMenu(),
      '/search': (context) => Search()
    }); //Loading
  }
}

