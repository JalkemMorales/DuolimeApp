import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loginhandler {
  final url = 'https://liked-walleye-trusting.ngrok-free.app/getProfile';
  Map<String, dynamic> _data = {};
  Future<bool> loginProfile(String username, String password) async {
    var pet = Uri.parse(url);
    try {
      final response = await http.post(
        pet,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );
      if (response.statusCode == 200) {
        _data = jsonDecode(response.body);
        debugPrint('Respuesta obtenida: ${response.body}');
        return true;
      } else {
        debugPrint('Error realizando la peticion: ${response.statusCode}');
        debugPrint('Error realizando la peticion: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    throw Error();
  }

  int getId() {
    return int.parse(_data['\$']['id']);
  }
}
