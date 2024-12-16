import 'package:duolime/handlers/Usernamehandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RankingHandler {
  final String url = 'https://actively-golden-lab.ngrok-free.app/getRanking';
  List<Map<String, dynamic>> _rankingData = [];
  Usernamehandler username = Usernamehandler();

  // Función para obtener el ranking del servidor
  Future<void> getRanking() async {
    var pet = Uri.parse(url);
    try {
      final response = await http.post(
        pet,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        // Convertir el JSON a la estructura deseada y ordenar por puntaje de mayor a menor
        _rankingData = await Future.wait(data.map((item) async {
          int id = int.parse(item['\$']['id']);
          int puntaje = int.parse(item['maxscore'][0]);

          // Obtener el nombre del usuario de forma asíncrona
          String nombre = await username.getUsername(id.toString());

          return {'id': id, 'nombre': nombre, 'puntaje': puntaje};
        }).cast<Future<Map<String, dynamic>>>());

        // Ordenar la lista por puntaje de mayor a menor
        _rankingData.sort((a, b) => b['puntaje'].compareTo(a['puntaje']));

        debugPrint('Ranking ordenado: $_rankingData');
      } else {
        debugPrint('Error realizando la petición: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // Función para obtener el tamaño del ranking
  int obtainLength() {
    return _rankingData.length;
  }

  // Función para obtener el nombre de un jugador en una posición específica
  String getNombre(int index) {
    if (index < _rankingData.length) {
      return _rankingData[index]['nombre'];
    }
    return 'Índice fuera de rango';
  }

  // Función para obtener los datos completos del ranking
  List<Map<String, dynamic>> getRankingData() {
    return _rankingData;
  }
}
