import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Puntajes {
  final url = 'https://liked-walleye-trusting.ngrok-free.app/getPuntaje';
  final urlguardar = 'https://liked-walleye-trusting.ngrok-free.app/registerPuntaje';
  int _data = 0;

  getPuntaje(String category, String id) async {
    var pet = Uri.parse(url);
    try{
      final response = await http.post(pet,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': id, 'category': category}),);
      if(response.statusCode == 200){
        _data = jsonDecode(response.body);
        debugPrint('Respuesta obtenida: $_data');
      }else{
        debugPrint('Error realizando la peticion: ${response.statusCode}');
        debugPrint('Error realizando la peticion: ${response.body}');
      }
    }catch (e){
      debugPrint('$e');
    }
  }
  
  registerPuntaje(id, category, newscore) async {
    var pet = Uri.parse(urlguardar);
    try{
      final response = await http.post(pet,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': id, 'category': category, 'newscore': newscore}),);
      if(response.statusCode == 200){
        debugPrint('Respuesta obtenida: ${response.body}');
      }else{
        debugPrint('Error realizando la peticion: ${response.statusCode}');
        debugPrint('Error realizando la peticion: ${response.body}');
      }
    }catch (e){
      debugPrint('$e');
    }
  }

  int returnPuntaje() {
      return _data;
  }
}
