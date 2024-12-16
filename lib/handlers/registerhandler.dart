import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Registerhandler {
  final url = 'https://actively-golden-lab.ngrok-free.app/registerProfile';
  final urlcorreo =
      'https://actively-golden-lab.ngrok-free.app/enviarCorreo';

  String generateRandomPassword({int length = 8}) {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final Random random = Random();

    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  registerProfile(String username, String correo) async {
    var pet = Uri.parse(url);
    var password = generateRandomPassword();
    try {
      final response = await http.post(
        pet,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );
      if (response.statusCode == 200) {
        debugPrint('Respuesta obtenida: ${response.body}');
      } else {
        debugPrint('Error realizando la peticion: ${response.statusCode}');
        debugPrint('Error realizando la peticion: ${response.body}');
      }
      sendEmail(correo, password);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  sendEmail(String email, String password) async {
    var pet = Uri.parse(urlcorreo);
    try {
      final response = await http.post(
        pet,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        debugPrint('Respuesta obtenida: ${response.body}');
      } else {
        debugPrint('Error realizando la peticion: ${response.statusCode}');
        debugPrint('Error realizando la peticion: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
