import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TriviaQuestions {
  final url = 'https://liked-walleye-trusting.ngrok-free.app/obtenerPregunta';
  List<dynamic> _data = [];

  fetchQuestions(String category) async {
    var pet = Uri.parse(url);
    try {
      final response = await http.post(
        pet,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'tema': category}),
      );
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        _data = decodedResponse['preguntas']; // Extraer la lista de preguntas
        debugPrint('Respuesta obtenida: $_data');
      } else {
        debugPrint('Error realizando la peticion: ${response.statusCode}');
        debugPrint('Error realizando la peticion: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  int obtainLength() {
    return _data.length;
  }

  List<Map<String, String>> getQuestions() {
    return List<Map<String, String>>.from(_data.map((item) => {
          'pregunta': item['pregunta'].toString(),
          'respuesta': item['respuesta'].toString(),
        }));
  }
}
