import 'package:flutter/material.dart';

class Trivia extends StatefulWidget {
  const Trivia({super.key});

  @override
  CardListState createState() => CardListState();
}

class CardListState extends State<Trivia> {
  List<Map<String, String>> _questions = []; // Lista de preguntas simulada
  late Trivia preguntas;
  int _currentQuestionIndex = 0;
  bool _isLastQuestion = false;
  bool _isLoading = true;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    preguntas = const Trivia();
    _fetchQuestions(); // Simula la llamada a la API
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
      await preguntas.fetchQuestions();
      if (!_isDisposed) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchQuestions() async {
    // Simulación de la respuesta de la API
    await Future.delayed(const Duration(seconds: 2)); // Simula tiempo de carga

    setState(() {
      _questions = [
        {'pregunta': 'La Tierra es plana', 'respuesta': 'F'},
        {'pregunta': 'El Sol gira alrededor de la Tierra', 'respuesta': 'F'},
        {'pregunta': 'El agua hierve a 100°C', 'respuesta': 'V'},
        {
          'pregunta': 'El ser humano puede respirar bajo el agua',
          'respuesta': 'F'
        },
        {'pregunta': 'El alfabeto español tiene 30 letras', 'respuesta': 'F'},
        {'pregunta': 'El oro es un elemento químico', 'respuesta': 'V'},
        {
          'pregunta': 'La electricidad es un tipo de energía renovable',
          'respuesta': 'V'
        },
        {
          'pregunta': 'El agua es un compuesto formado por hidrógeno y oxígeno',
          'respuesta': 'V'
        },
        {
          'pregunta': 'La velocidad de la luz es de 300,000 km/s',
          'respuesta': 'V'
        },
        {
          'pregunta': 'La Mona Lisa fue pintada por Vincent van Gogh',
          'respuesta': 'F'
        }
      ];
    });
  }

  void _checkAnswer(String userAnswer) {
    String correctAnswer = _questions[_currentQuestionIndex]['respuesta']!;
    if (userAnswer == correctAnswer) {
      debugPrint('Respuesta correcta');
    } else {
      debugPrint('Respuesta incorrecta');
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _isLastQuestion = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trivia - Preguntas y Respuestas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _questions.isEmpty
            ? const Center(
                child:
                    CircularProgressIndicator()) // Mostrar indicador de carga
            : _isLastQuestion
                ? const Center(
                    child: Text(
                      '¡Has completado el juego!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Pregunta ${_currentQuestionIndex + 1} de ${_questions.length}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _questions[_currentQuestionIndex]['pregunta']!,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                          height: 60), // Espacio entre pregunta y botones
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _checkAnswer('V'),
                              child: Card(
                                elevation: 4,
                                color: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Center(
                                    child: Text(
                                      'Verdadero',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 16), // Separador entre las dos tarjetas
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _checkAnswer('F'),
                              child: Card(
                                elevation: 4,
                                color: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Center(
                                    child: Text(
                                      'Falso',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }
}
