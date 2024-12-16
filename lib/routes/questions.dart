import 'package:duolime/handlers/trivia.dart';
import 'package:flutter/material.dart';

class Trivia extends StatefulWidget {
  const Trivia({super.key});

  @override
  CardListState createState() => CardListState();
}

class CardListState extends State<Trivia> {
  List<Map<String, String>> _questions = []; // Lista de preguntas simulada
  late Map<String, String> args;
  late TriviaQuestions preguntas;
  int correctAnswer = 0;
  int _currentQuestionIndex = 0;
  bool _isLastQuestion = false;
  bool _isLoading = true;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    preguntas = TriviaQuestions();
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
    args = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    if (_isLoading) {
      obtainData();
    }
  }

  Future<void> obtainData() async {
    debugPrint(_isDisposed.toString());
    if (!_isDisposed) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchQuestions() async {
    // Simulación de la respuesta de la API
    await Future.delayed(const Duration(seconds: 2)); // Simula tiempo de carga
    await preguntas.fetchQuestions("${args['category']}");
    setState(() {
      _questions = preguntas.getQuestions();
    });
  }

  void _checkAnswer(String userAnswer) {
    String correctAnswer = _questions[_currentQuestionIndex]['respuesta']!;
    if (userAnswer == correctAnswer) {
      debugPrint('Respuesta correcta');
      setState(() {
        this.correctAnswer += 1;
      });
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
            ? const Center(child: CircularProgressIndicator()) // Mostrar indicador de carga
            : _isLastQuestion
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '¡Has completado el juego!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed('/finish', arguments: {
                            'correct': correctAnswer,
                            'category': "${args['category']}",
                            'id': "${args['id']}",
                            'level': "${args['level']}",
                            'progress': "${args['progress']}",
                          });
                        },
                        child: Card(
                          elevation: 4,
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: Text(
                                'Ver Resultados',
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
                    ],
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
