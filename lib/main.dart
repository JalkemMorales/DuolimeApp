import 'package:duolime/routes/categories.dart';
import 'package:duolime/routes/centermenu.dart';
import 'package:duolime/routes/gamefinished.dart';
import 'package:duolime/routes/levels.dart';
import 'package:duolime/routes/loginprofile.dart';
import 'package:duolime/routes/menu.dart';
import 'package:duolime/routes/questions.dart';
import 'package:duolime/routes/ranking.dart';
import 'package:duolime/routes/registerprofile.dart';
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
        '/': (context) => const MenuPrincipal(),
        '/register': (context) => const Registerprofile(),
        '/login': (context) => const LoginScreen(),
        '/menu': (context) => const MenuScreen(),
        '/ranking': (context) => const Ranking(),
        '/categories': (context) => const Categories(),
        '/levels': (context) => const Levels(),
        '/trivia': (context) => const Trivia(),
        '/finish': (context) => const EndGameScreen(),
      },
    );
  }
}


