import 'package:flutter/material.dart';
import 'package:registro_de_miembros/src/registro/pages/login_page.dart';
import 'package:registro_de_miembros/src/registro/pages/registro_pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Registro',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => const LoginPages(),
        'registro': (BuildContext context) => RegistroPages('1', '1'),
      },
    );
  }
}
