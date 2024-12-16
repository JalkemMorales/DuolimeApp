import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Progresohandler {
  final url = 'https://liked-walleye-trusting.ngrok-free.app/getProgress';
  final urlguardar = 'https://liked-walleye-trusting.ngrok-free.app/registerProgress';
  int _data = 0;

  getProgress(String id, String category) async {
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

  registerProgress(String id, String category, int newlevel, int progreso) async {
    debugPrint("PROGRESO: $progreso");
    debugPrint("NEWLEVEL: $newlevel");
    if(newlevel <= progreso){
      newlevel = progreso;
    }
    var pet = Uri.parse(urlguardar);
    try{
      final response = await http.post(pet,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': id, 'category': category, 'newlevel': newlevel}),);
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

  int returnProgress() {
      return _data;
  }
}
