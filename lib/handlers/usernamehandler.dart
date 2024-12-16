import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Usernamehandler {
  final url = 'https://actively-golden-lab.ngrok-free.app/getUsername';
  String _data = '';

  Future<String> getUsername(String id) async {
    var pet = Uri.parse(url);
    try{
      final response = await http.post(pet,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': id}),);
      if(response.statusCode == 200){
        _data = response.body;
        debugPrint('Respuesta obtenida: $_data');
        return _data;
      }else{
        debugPrint('Error realizando la peticion: ${response.statusCode}');
        debugPrint('Error realizando la peticion: ${response.body}');
        return 'nodata';
      }
    }catch (e){
      debugPrint('$e');
    }
    throw Error();
  }

  String returnUsername() {
      return _data;
  }
}
