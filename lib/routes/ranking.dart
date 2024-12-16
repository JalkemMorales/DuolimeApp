import 'package:duolime/handlers/rankinghandler.dart';
import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  RankingScreen createState() => RankingScreen();
}

class RankingScreen extends State<Ranking> {
  // Datos de ejemplo (puedes cambiarlos por los datos reales que quieras mostrar)
  late List<Map<String, dynamic>> _rankingData = [
    {'id': 1, 'nombre': 'Jugador 1', 'puntaje': 1500},
    {'id': 2, 'nombre': 'Jugador 2', 'puntaje': 1200},
    {'id': 3, 'nombre': 'Jugador 3', 'puntaje': 900},
    {'id': 4, 'nombre': 'Jugador 4', 'puntaje': 800},
    {'id': 5, 'nombre': 'Jugador 5', 'puntaje': 700},
  ];

  late RankingHandler rank;
  late Map<String, String> args;
  bool _isLoading = true;
  bool _isDisposed = false;

  @override
  void initState() {
    rank = RankingHandler();
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
    if (_isLoading) {
      obtainData();
    }
  }

  Future<void> obtainData() async {
    debugPrint(_isDisposed.toString());
    if (!_isDisposed) {
      await rank.getRanking();
      if (!_isDisposed) {
        setState(() {
          _rankingData = rank.getRankingData();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Ranking de Jugadores',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
          
                  // Lista de ranking con tarjetas
                  Expanded(
                    child: ListView.builder(
                      itemCount: _rankingData.length,
                      itemBuilder: (context, index) {
                        var jugador = _rankingData[index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                jugador['id'].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              jugador['nombre'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                                fontSize: 18,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.purpleAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${jugador['puntaje']} Pts',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
          ),
        ],
      ),
    );
  }
}
