import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Listcategories {
  final url = 'https://actively-golden-lab.ngrok-free.app/getCategories';
  List<dynamic> _data = [];

  getCategories() async{
    var pet = Uri.parse(url);
    try{
      final response = await http.post(pet,
      headers: {
        'Content-Type': 'application/json',
      },);
      if(response.statusCode == 200){
        _data = jsonDecode(response.body);
        debugPrint('Respuesta obtenida: $_data');
      }else{
        debugPrint('Error realizando la peticion: ${response.statusCode}');
      }
    }catch (e){
      debugPrint('$e');
    }
  }

  int obtainLength(){
    return _data.length;
  }

  String getNombre(int index){
if (index < _data.length) {
      return _data[index]['name'][0];
    }
    return 'Índice fuera de rango';
  }

  /*String getprojectId(int index){
    if (index < _data.length) {
      return _data[index]['projectId'];
    }
    return "No encontrado";
  }

  String getType(int index){
    if (index < _data.length) {
      return _data[index]['type'];
    }
    return 'Índice fuera de rango';
  }*/
}