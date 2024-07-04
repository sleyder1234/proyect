import 'package:mongo_dart/mongo_dart.dart';

class Programador {
  ObjectId id;
  String nombre;
  String rango;

  Programador({required this.id, required this.nombre,  required this.rango});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'rango': rango,
    };
  }

  Programador.fromMap(Map<String, dynamic> map)
      : nombre = map['nombre'],
        id = map['_id'],
        rango = map['rango'];
}
