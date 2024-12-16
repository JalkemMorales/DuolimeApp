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
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFDAC5FF), // Morado claro
            Color(0xFFC17FFF),  // Morado oscuro
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen centrada arriba del título
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Image.asset(
                'assets/img/logo1.png', // Ruta de la imagen
                width: 200, // Tamaño de la imagen
                height: 200,
              ),
            ),

            // Título central
            const Text(
              'Duolime',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto en blanco
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
                color: const Color.fromARGB(255, 255, 255, 255), // Color de fondo del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 30),
                  child: Text(
                    'Registrarse',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 104, 56, 150), // Color del texto
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Espacio entre los botones

            // Card para Iniciar sesión
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: Card(
                elevation: 8,
                color: const Color.fromARGB(255, 104, 56, 150), // Color de fondo del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 30),
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Color del texto
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
