import 'package:flutter/material.dart';
import 'package:appconmongo/bd/mongodb.dart';
import 'package:appconmongo/ui/portada.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Mongodb.conectar();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de programadores',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 183, 110)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Portada(),
    );
  }
}

