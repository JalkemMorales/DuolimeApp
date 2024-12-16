import 'package:duolime/handlers/registerhandler.dart';
import 'package:flutter/material.dart';

class Registerprofile extends StatefulWidget {
  const Registerprofile({super.key});

  @override
  CardListState createState() => CardListState();
}

class CardListState extends State<Registerprofile> {
  // Controladores para los campos de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  late Registerhandler perfil = Registerhandler();

  // Clave global para el formulario
  final _formKey = GlobalKey<FormState>();

  // Función para mostrar el AlertDialog
  void _mostrarDialogoRegistro(String nombre, String correo) {
    showDialog(
      context: context,
      barrierDismissible: false, // Evita que el dialogo se cierre tocando fuera de él
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Registro Exitoso!'),
          content: Text(
              'Se ha enviado un correo a $correo con tu contraseña para acceder, no es necesario volver a registrarse.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el dialogo
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 178, 133, 255), // Morado claro
            Color.fromARGB(255, 104, 56, 150),    // Morado oscuro
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey, // Asociamos el formulario con la clave
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Registro de Usuario',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 104, 56, 150), // Morado oscuro
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Crea una cuenta nueva en minutos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Campo de nombre con validación
                    TextFormField(
                      controller: _nombreController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        hintText: 'Tu nombre completo',
                        labelStyle: const TextStyle(color: Color.fromARGB(255, 104, 56, 150)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 104, 56, 150)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Campo de correo electrónico con validación
                    TextFormField(
                      controller: _correoController,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        hintText: 'Tu correo electrónico',
                        labelStyle: const TextStyle(color: Color.fromARGB(255, 104, 56, 150)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 104, 56, 150)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu correo electrónico';
                        }
                        // Validación básica de correo electrónico
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Por favor ingresa un correo válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    // Botón de registrar
                    ElevatedButton(
                      onPressed: () {
                        // Validamos el formulario antes de registrar
                        if (_formKey.currentState?.validate() ?? false) {
                          String nombre = _nombreController.text;
                          String correo = _correoController.text;

                          // Aquí se simula el registro
                          debugPrint("Registrando con nombre: $nombre y correo: $correo");

                          // Limpiamos los campos después del registro
                          _nombreController.clear();
                          _correoController.clear();
                          perfil.registerProfile(nombre, correo);
                          _mostrarDialogoRegistro(nombre, correo);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 104, 56, 150), // Morado oscuro
                        minimumSize: const Size(double.infinity, 50), // Asegura que el botón ocupe todo el ancho
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Texto en blanco
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

}
