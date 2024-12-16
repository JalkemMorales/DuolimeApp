import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Puntajes {
  final url = 'https://actively-golden-lab.ngrok-free.app/getPuntaje';
  int _data = 0;

  getPuntaje(String category) async {
    var pet = Uri.parse(url);
    try{
      final response = await http.post(pet,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': '1', 'category': category}),);
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

  int returnPuntaje() {
      return _data;
  }
}
