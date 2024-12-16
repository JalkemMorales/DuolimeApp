import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Streakhandler {
  final url = 'https://actively-golden-lab.ngrok-free.app/updateRacha';
  int _data = 0;

  getStreak(String id) async {
    var pet = Uri.parse(url);
    try{
      final response = await http.post(pet,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': id}),);
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

  int returnStreak() {
      return _data;
  }
}
