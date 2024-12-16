import 'package:duolime/routes/categories.dart';
import 'package:duolime/routes/levels.dart';
import 'package:duolime/routes/questions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Categories(),
        '/levels': (context) => const Levels(),
        '/trivia': (context) => const Trivia(),
      },
    );
  }
}


