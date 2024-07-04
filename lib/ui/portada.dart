import 'package:flutter/material.dart';
import 'package:appconmongo/bd/mongodb.dart';
import 'package:appconmongo/modelos/programador.dart';
import 'package:appconmongo/ui/ficha_programador.dart';
import 'package:appconmongo/ui/editar_programador.dart';

class Portada extends StatefulWidget {
  @override
  _PortadaState createState() => _PortadaState();
}

class _PortadaState extends State<Portada> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Mongodb.getProgramadores(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              color: Colors.white,
              child: const LinearProgressIndicator(
                backgroundColor: Colors.black,
              ));
        } else if (snapshot.hasError) {
          return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "Lo sentimos, ocurrio un error. Intentelo nuevamente",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("Programadores buenos"),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FichaProgramador(
                        programador: Programador.fromMap(snapshot.data[index]),
                        onTapDelete: () async {
                          _eliminarProgramador(
                              Programador.fromMap(snapshot.data[index]));
                        },
                        onTapEdit: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return EditarProgramador();
                                  },
                                  settings: RouteSettings(
                                    arguments: Programador.fromMap(
                                        snapshot.data[index]),
                                  ))).then((value) => setState(() {}));
                        }));
              },
              itemCount: snapshot.data.length,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return EditarProgramador();
                })).then((value) => setState(() {}));
              },
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  _eliminarProgramador(Programador programador) async {
    await Mongodb.eliminar(programador);
    setState(() {});
  }
}
