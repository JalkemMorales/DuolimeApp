import 'package:duolime/handlers/puntajes.dart';
import 'package:flutter/material.dart';

class Levels extends StatefulWidget {
  const Levels({super.key});

  @override
  CardListState createState() => CardListState();
}

class CardListState extends State<Levels> {
  late Puntajes puntaje;
  late Map<String, String> args;
  bool _isLoading = true;
  bool _isDisposed = false;
  int lastScore = 0;

  @override
  void initState() {
    puntaje = Puntajes();
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
        await puntaje.getPuntaje("${args['category']}");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${args['category']}"),
      ),
      body: Column(
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
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
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/trivia');
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        'Nivel ${index + 1}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
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
    );
  }
}
