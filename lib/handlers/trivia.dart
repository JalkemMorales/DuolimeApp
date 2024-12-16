import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Trivia {
  final url = 'https://actively-golden-lab.ngrok-free.app/obtenerPregunta';
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
        _data = jsonDecode(response.body);
        debugPrint('Respuesta obtenida: $_data');
      } else {
        debugPrint('Error realizando la peticion: ${response.statusCode}');
        debugPrint('Error realizando la peticion: ${response.body}');
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  int obtainLength() {
    return _data.length;
  }

  List<Map<String, String>> getQuestions(int index) {
    if (index < _data.length) {
      return _data[index];
    }
    throw Error();
  }
}
