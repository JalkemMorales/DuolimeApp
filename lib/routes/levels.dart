import 'package:duolime/handlers/progresohandler.dart';
import 'package:duolime/handlers/puntajes.dart';
import 'package:flutter/material.dart';

class Levels extends StatefulWidget {
  const Levels({super.key});

  @override
  CardListState createState() => CardListState();
}

class CardListState extends State<Levels> {
  late Puntajes puntaje;
  late Progresohandler progress;
  late Map<String, String> args;
  bool _isLoading = true;
  bool _isDisposed = false;
  int lastScore = 0;
  int progreso = 0;

  @override
  void initState() {
    puntaje = Puntajes();
    progress = Progresohandler();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    super.didChangeDependencies();
    if (_isLoading) {
      obtainData();
    }
  }

  Future<void> obtainData() async {
    debugPrint(_isDisposed.toString());
    if (!_isDisposed) {
      if (!_isDisposed) {
        await puntaje.getPuntaje("${args['category']}", "${args['id']}");
        await progress.getProgress("${args['id']}", "${args['category']}");
        setState(() {
          _isLoading = false;
          progreso = progress.returnProgress();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mapa que define los colores según la categoría
    final Map<String, Map<String, Color>> categoryColors = {
      'Banderas': {
        'background': const Color.fromARGB(255, 255, 186, 181),
        'button': Colors.red,
      },
      'Series': {
        'background': const Color.fromARGB(255, 255, 220, 167),
        'button': Colors.orange,
      },
      'Películas': {
        'background': const Color.fromARGB(255, 255, 242, 182),
        'button': const Color.fromARGB(255, 255, 208, 0),
      },
      'Cultura pop': {
        'background': const Color.fromARGB(255, 221, 255, 210),
        'button': const Color.fromARGB(255, 110, 197, 83),
      },
      'Historia': {
        'background': const Color.fromARGB(255, 157, 255, 170),
        'button': const Color.fromARGB(255, 38, 180, 57),
      },
      'Arte': {
        'background': const Color.fromARGB(255, 193, 255, 249),
        'button': Colors.teal,
      },
      'Geografía': {
        'background': const Color.fromARGB(255, 179, 221, 255),
        'button': Colors.blue,
      },
      'Anime': {
        'background': const Color.fromARGB(255, 180, 221, 255),
        'button': const Color.fromARGB(255, 11, 102, 177),
      },
      'Ciencia': {
        'background': const Color.fromARGB(255, 231, 196, 255),
        'button': const Color.fromARGB(255, 192, 96, 255),
      },
      'Libros': {
        'background': Colors.purple.shade100,
        'button': Colors.purple,
      },
      'Videojuegos': {
        'background': const Color.fromARGB(255, 255, 207, 239),
        'button': const Color.fromARGB(255, 255, 128, 213),
      },
      'Música': {
        'background': const Color.fromARGB(255, 255, 183, 225),
        'button': const Color.fromARGB(255, 255, 0, 149),
      },
      // Agrega más categorías si es necesario
    };

    // Obtén los colores según la categoría actual
    final String currentCategory = args['category'] ?? 'Default';
    final Map<String, Color> colors =
        categoryColors[currentCategory] ?? {
          'background': Colors.grey.shade100,
          'button': Colors.grey.shade700,
        };

    return Scaffold(
      appBar: AppBar(
        title: Text(currentCategory, style: const TextStyle(color: Colors.white)),
        backgroundColor: colors['button'], // Cambia el color del AppBar
      ),
      body: Container(
        color: colors['background'], // Fondo según la categoría
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Última puntuación:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    puntaje.returnPuntaje().toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors['button'], // Color del texto dinámico
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos columnas
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 2.0, // Proporción de las tarjetas
                ),
                itemCount: 10, // Mostrar 10 tarjetas
                itemBuilder: (context, index) {
                  bool isUnlocked = index < progreso; // Nivel desbloqueado

                  return GestureDetector(
                    onTap: isUnlocked ? () {
                      Navigator.pushNamed(context, '/trivia', arguments: {
                        'category': currentCategory,
                        'id': "${args['id']}",
                        'level': (index+1).toString(),
                        'progress': progreso.toString(),
                      });
                    } : null, // Deshabilitar acción si no está desbloqueado
                    child: Card(
                      elevation: 4,
                      color: isUnlocked ? colors['button'] : Colors.grey, // Botón desbloqueado o gris
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Nivel ${index + 1}',
                          style: TextStyle(
                            fontSize: 24,
                            color: isUnlocked ? Colors.white : Colors.black38, // Texto en gris si está bloqueado
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
