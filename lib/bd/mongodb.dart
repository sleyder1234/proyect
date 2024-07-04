import 'package:mongo_dart/mongo_dart.dart';
import 'package:appconmongo/modelos/programador.dart';
import 'package:appconmongo/utilidades/costantes.dart';

class Mongodb {
  static var bd, coleccionProgramadores;

  static conectar() async {
    bd = await Db.create(CONEXION);
    await bd.open(secure: true);
    coleccionProgramadores = bd.collection(COLECCION);
  }

  static Future<List<Map<String, dynamic>>> getProgramadores() async {
    try {
      final programadores = await coleccionProgramadores.find().toList();
      return programadores;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static insertar(Programador programador) async {
    await coleccionProgramadores.insertAll([programador.toMap()]);
  }

  static actualizar(Programador programador) async {
    var filter = where.eq("_id", programador.id);
    var update = {
      "\$set": {
        "nombre": programador.nombre,
        "rango": programador.rango,
      }
    };
    await coleccionProgramadores.updateOne(filter, update);
  }

  static eliminar(Programador programador) async {
    await coleccionProgramadores.remove(where.id(programador.id));
  }
}
