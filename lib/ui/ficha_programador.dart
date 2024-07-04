import 'package:flutter/material.dart';
import 'package:appconmongo/modelos/programador.dart';

class FichaProgramador extends StatelessWidget {
  FichaProgramador(
      {required this.programador,
      required this.onTapDelete,
      required this.onTapEdit});
  final Programador programador;
  final VoidCallback onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Text('${programador.rango}', style: Theme.of(context).textTheme.headlineMedium),
        title: Text(programador.nombre),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Icon(Icons.edit),
              onTap: onTapEdit,
            ),
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: onTapDelete,
            )
          ],
        ),

      
      )
    );

  }


}
