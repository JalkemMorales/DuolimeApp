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
      backgroundColor: Colors.blue[100], // Fondo degradado similar al que pediste
      appBar: AppBar(
        title: const Text('Menú Principal'),
        elevation: 0,
      ),
      body: Center(
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
                        color: Colors.purple,
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
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}