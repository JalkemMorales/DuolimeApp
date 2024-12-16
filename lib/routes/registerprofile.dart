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
      backgroundColor: Colors.blue[100], // Fondo degradado similar al de la imagen
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
        elevation: 0,
      ),
      body: Center(
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
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Crea una cuenta nueva en minutos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Campo de nombre con validación
                    TextFormField(
                      controller: _nombreController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        hintText: 'Tu nombre completo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
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
                          // Si el formulario es válido, podemos proceder con el registro
                          String nombre = _nombreController.text;
                          String correo = _correoController.text;

                          // Aquí se simula el registro
                          debugPrint("Registrando con nombre: $nombre y correo: $correo");

                          // Limpiamos los campos después del registro
                          _nombreController.clear();
                          _correoController.clear();
                          perfil.registerProfile(nombre, correo);
                          // Mostrar el Dialogo de éxito
                          _mostrarDialogoRegistro(nombre, correo);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Color de fondo
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
    );
  }
}
