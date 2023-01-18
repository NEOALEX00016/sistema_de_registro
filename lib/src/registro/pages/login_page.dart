import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:registro_de_miembros/src/registro/pages/registro_pages.dart';
import '../comom/global.dart' as global;
import 'package:registro_de_miembros/Animation/FadeAnimation.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({Key? key}) : super(key: key);

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

String username = '';
String nombre = '';
String zona = '';

class _LoginPagesState extends State<LoginPages> {
  TextEditingController controlleruser = new TextEditingController();
  TextEditingController controllerpass = new TextEditingController();

  String mensaje = '';
  String id = '';

  Future login() async {
    var url = Uri.parse(global.servidor + "login.php");
    var response = await http.post(url, body: {
      "username": controlleruser.text,
      "password": controllerpass.text
    });

    var datauser = jsonDecode(response.body);
    final length = datauser.length;

    if (length == 0) {
      if (mounted) {
        setState(() {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text('Usuario o Contraseña Incorrecto')));
        });
      }
    } else {
      if (mounted) {
        /*  SharedPreferences log = await SharedPreferences.getInstance();
        log.setString("id_mensajero", datauser['id']);
        log.setString("Mensajero", datauser['mensajero']);*/
        setState(() {
          username = datauser[0]['mensajero'];
          id = datauser[0]['id_mensajeros'].toString();
          zona = datauser[0]['zona'].toString();
        });

        Navigator.of(this.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => RegistroPages(username)),
            (Route<dynamic> route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue.shade900,
          Colors.blue.shade800,
          Colors.blue.shade700
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1,
                      Text(
                        "Sistema de Registro de Militante",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ],
              ),
            ),
            FadeAnimation(
              1,
              SizedBox(
                height: 5,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(58, 74, 231, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            FadeAnimation(
                              1,
                              Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                  controller: controlleruser,
                                  decoration: InputDecoration(
                                      hintText: "Usuario",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            FadeAnimation(
                                1,
                                Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    obscureText: true,
                                    controller: controllerpass,
                                    decoration: InputDecoration(
                                        hintText: "Contraseña",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      FadeAnimation(
                        1,
                        Text(
                          "El Registro se Realiza desde el Administrador",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      FadeAnimation(
                          1,
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue.shade500,
                            ),
                            child: Center(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                onPressed: () {
                                  login();
                                },
                                child: Text(
                                  'Acceder',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                //fontSize: 20,
                                //fontWeight: FontWeight.w500),
                              ),
                            ),
                          )),
                      Text(
                        mensaje,
                        style: TextStyle(fontSize: 25.0, color: Colors.red),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
