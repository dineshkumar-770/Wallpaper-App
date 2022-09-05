import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/mainscreen.dart';
import 'package:wallpaper_app/screens/nature.dart';
import 'package:wallpaper_app/servicies/trending.dart';
import 'package:wallpaper_app/servicies/wallpaper.dart';
import 'package:wallpaper_app/widgets/wallpaper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
