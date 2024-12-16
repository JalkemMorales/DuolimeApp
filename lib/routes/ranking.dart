import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  RankingScreen createState() => RankingScreen();
}

class RankingScreen extends State<Ranking> {
  // Datos de ejemplo (puedes cambiarlos por los datos reales que quieras mostrar)
  final List<Map<String, dynamic>> _rankingData = [
    {'id': 1, 'nombre': 'Jugador 1', 'puntaje': 1500},
    {'id': 2, 'nombre': 'Jugador 2', 'puntaje': 1200},
    {'id': 3, 'nombre': 'Jugador 3', 'puntaje': 900},
    {'id': 4, 'nombre': 'Jugador 4', 'puntaje': 800},
    {'id': 5, 'nombre': 'Jugador 5', 'puntaje': 700},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ranking',
          style: TextStyle(color: Colors.white), // Título en color blanco
        ),
        backgroundColor: const Color.fromARGB(255, 160, 106, 255), // Morado oscuro en el AppBar
        elevation: 0,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Tabla de Ranking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Color de texto en blanco
                ),
              ),
              const SizedBox(height: 20),

              // Contenedor con fondo blanco y bordes morados para la tabla
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Fondo blanco para la tabla
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color.fromARGB(255, 178, 133, 255), // Bordes morados
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.all(color: Colors.transparent),
                      columnWidths: const {
                        0: FixedColumnWidth(50), // Columna ID
                        1: FlexColumnWidth(),    // Columna Nombre
                        2: FixedColumnWidth(80), // Columna Puntaje
                      },
                      children: [
                        // Encabezado de la tabla
                        const TableRow(
                          decoration: BoxDecoration(color: Color(0xFF6A1B9A)), // Morado intermedio para el encabezado
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'ID',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Texto blanco
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Nombre',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Texto blanco
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Puntaje',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Texto blanco
                              ),
                            ),
                          ],
                        ),

                        // Desglose dinámico de los datos
                        for (var jugador in _rankingData)
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.transparent, // Fondo transparente para las filas
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  jugador['id'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black), // Texto negro
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  jugador['nombre'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black), // Texto negro
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  jugador['puntaje'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black), // Texto negro
                                ),
                              ),
                            ],
                          ),
                      ],
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