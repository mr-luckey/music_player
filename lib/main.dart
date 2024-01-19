// import 'package:audio_player/Views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/Views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Player',
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)),
      home: const MyHomePage(),
    );
  }
}
