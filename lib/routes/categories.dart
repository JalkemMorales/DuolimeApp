import 'package:duolime/handlers/listcategories.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  CardListState createState() => CardListState();
}

class CardListState extends State<Categories> {
  late Listcategories categories;
  late Map<String, String> args;
  bool _isLoading = true;
  bool _isDisposed = false;

  @override
  void initState() {
    categories = Listcategories();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    if (_isLoading) {
      obtainData();
    }
  }

  Future<void> obtainData() async {

    debugPrint(_isDisposed.toString());
    if (!_isDisposed) {
      await categories.getCategories();
      if (!_isDisposed) {
        setState(() {
          _isLoading = false;
        });
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    // Lista de colores para las categorías
    final List<Color> categoryColors = [
      Colors.red,
      Colors.orange,
      const Color.fromARGB(255, 255, 208, 0),
      const Color.fromARGB(255, 110, 197, 83),
      const Color.fromARGB(255, 38, 180, 57),
      Colors.teal,
      Colors.blue,
      const Color.fromARGB(255, 11, 102, 177),
      const Color.fromARGB(255, 192, 96, 255),
      Colors.purple,
      const Color.fromARGB(255, 255, 128, 213),
      const Color.fromARGB(255, 255, 0, 149),
    ];

    return Scaffold(
      // Fondo morado para la pantalla completa
      backgroundColor: const Color.fromARGB(255, 178, 133, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 40.0),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "Categorías",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Texto en blanco
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: categories.obtainLength(),
                            itemBuilder: (context, index) {
                              // Asigna un color según el índice, usando un ciclo
                              final color = categoryColors[index % categoryColors.length];
                              
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 2),
                                child: Card(
                                  color: color, // Fondo del Card con el color asignado
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/levels', arguments: {
                                            'category': categories.getNombre(index),
                                            'id': "${args['id']}",
                                          });
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.height *
                                          1,
                                      height: 150,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              categories.getNombre(index),
                                              style: const TextStyle(
                                                fontSize: 25.0,
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
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

}
