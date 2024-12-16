import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Menú Principal',
        style: TextStyle(color: Colors.white),
      ),
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 160, 106, 255), // Morado oscuro
    ),
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 178, 133, 255), // Morado claro
            Color.fromARGB(255, 104, 56, 150), // Morado oscuro
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón "Jugar" como tarjeta (Card)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/categories');
                },
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    width: double.infinity,
                    child: const Text(
                      'Jugar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 104, 56, 150),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Botón "Ver Ranking" como tarjeta (Card)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/ranking');
                },
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    width: double.infinity,
                    child: const Text(
                      'Ver Ranking',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 104, 56, 150),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


}