import 'package:duolime/handlers/progresohandler.dart';
import 'package:duolime/handlers/puntajes.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EndGameScreen extends StatefulWidget {
  const EndGameScreen({super.key});

  @override
  EndGameState createState() => EndGameState();
}

class EndGameState extends State<EndGameScreen> {
  int correctAnswers = 0;
  Puntajes puntaje = Puntajes();
  Progresohandler progress = Progresohandler();
  bool _isDisposed = false;

  final int totalQuestions = 10;
  late Map<String, dynamic> args;

  @override
  void initState() {
    super.initState();
    _isDisposed = false;
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (!_isDisposed) {
      correctAnswers = args["correct"] as int;
      debugPrint("${args["level"]}");
      var newlevel = (int.parse(args["level"] ?? '0')) + 1;
      var progreso = (int.parse(args["progress"] ?? '0'));
      await puntaje.registerPuntaje(
          "${args['id']}", "${args['category']}", "${args['correct']}");
      await progress.registerProgress(
          "${args['id']}", "${args['category']}", newlevel, progreso);
      _isDisposed = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fin del Juego'),
        automaticallyImplyLeading: false, // Deshabilita el botón de retroceso
        backgroundColor: const Color.fromARGB(255, 104, 56, 150),
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              color: Colors.white, // Fondo blanco para toda la tarjeta
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '¡Juego Terminado!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 104, 56, 150),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Gráfico Circular
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: _buildPieChartSections(),
                          centerSpaceRadius: 50,
                          sectionsSpace: 2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Texto de resultados
                    Text(
                      'Respuestas correctas: $correctAnswers / $totalQuestions',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Botón tipo Card para volver al menú principal
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).popAndPushNamed('/menu', arguments: {
                          'id': "${args['id']}",
                        });
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: const Color.fromARGB(255, 104, 56, 150),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.home, size: 40, color: Colors.white),
                                SizedBox(height: 10),
                                Text(
                                  'Volver al Menú Principal',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
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


  // Función que construye las secciones del gráfico circular
  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: correctAnswers.toDouble(),
        title: '$correctAnswers Correctas',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: (totalQuestions - correctAnswers).toDouble(),
        title: '${totalQuestions - correctAnswers} Incorrectas',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
