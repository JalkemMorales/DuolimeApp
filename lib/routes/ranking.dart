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
        title: const Text('Ranking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Tabla de Ranking',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),

            // Tabla para mostrar el ranking
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: const {
                    0: FixedColumnWidth(50), // Columna ID
                    1: FlexColumnWidth(),    // Columna Nombre
                    2: FixedColumnWidth(80), // Columna Puntaje
                  },
                  children: [
                    // Encabezado de la tabla
                    const TableRow(
                      decoration: BoxDecoration(color: Colors.grey),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('ID', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Nombre', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Puntaje', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),

                    // Desglose dinámico de los datos
                    for (var jugador in _rankingData)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(jugador['id'].toString(), textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(jugador['nombre'], textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(jugador['puntaje'].toString(), textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}