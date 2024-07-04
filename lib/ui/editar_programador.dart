import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:appconmongo/bd/mongodb.dart';
import 'package:appconmongo/modelos/programador.dart';

class EditarProgramador extends StatefulWidget {
  @override
  _EditarProgramadorState createState() => _EditarProgramadorState();
}

class _EditarProgramadorState extends State<EditarProgramador> {
  static const EDICION = 1;
  static const INSERCION = 2;

  TextEditingController nombreController = TextEditingController();
  TextEditingController rangoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textoWidget = "Añadir Programador";
    int operacion = INSERCION;
    Programador? programador;

    if (ModalRoute.of(context)?.settings.arguments != null) {
      operacion = EDICION;
      programador = ModalRoute.of(context)?.settings.arguments as Programador;
      nombreController.text = programador.nombre;
      rangoController.text = programador.rango;
      textoWidget = "editar Programador";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(textoWidget),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: nombreController,
                      decoration: InputDecoration(labelText: "Nombre"),
                      keyboardType: TextInputType.text,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: rangoController,
                      decoration: InputDecoration(labelText: "Rango"),
                      keyboardType: TextInputType.text,
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: ElevatedButton(
                child: Text(textoWidget),
                onPressed: () {
                  if (operacion == EDICION) {
                    _actualizarProgramador(programador!);
                  } else {
                    _insertarProgramador();
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _insertarProgramador() async {
    final programador = Programador(
        id: M.ObjectId(),
        nombre: nombreController.text,
        rango: rangoController.text);
    await Mongodb.insertar(programador);
  }

  _actualizarProgramador(Programador programador) async {
    final p = Programador(
      id: programador.id,
      nombre: nombreController.text,
      rango: rangoController.text,
    );
    await Mongodb.actualizar(p);
  }

  @override
  void dispose() {
    super.dispose();
    nombreController.dispose();
    rangoController.dispose();
  }
}
