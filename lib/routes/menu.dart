import 'package:flutter/material.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  CardListState createState() => CardListState();
}

class CardListState extends State<MenuPrincipal> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título central
            const Text(
              'Duolime',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 60), // Espacio entre el título y los botones

            // Card para Registrarse
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/register');
              },
              child: Card(
                elevation: 8,
                color: Colors.teal[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 30),
                  child: Text(
                    'Registrarse',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Espacio entre los botones

            // Card para Iniciar sesión
            GestureDetector(
              onTap: () {
                // Acción para iniciar sesión
                debugPrint("Ir a la pantalla de inicio de sesión");
              },
              child: Card(
                elevation: 8,
                color: Colors.teal[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 30),
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
