import 'package:agenda_contactos/crearContactos.dart';
import 'package:agenda_contactos/listarContactos.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(routes: {
    "/": (BuildContext context) => ListarContactos(),
    "/create": (BuildContext context) => CrearContactos()
  }));
}
