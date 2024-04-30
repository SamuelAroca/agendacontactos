import 'package:agenda_contactos/contactProvider.dart';
import 'package:agenda_contactos/contactResponseModel.dart';
import 'package:flutter/material.dart';

class ListarContactos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListarContactos();
  }
}

class _ListarContactos extends State<ListarContactos> {
  List<Widget> listadoContactos = <Widget>[];

  @override
  Widget build(BuildContext context) {
    obtenerContactos();
    return Scaffold(
        appBar: AppBar(
          title: Text("Listado de contactos"),
        ),
        body: Center(
            child: ListView(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: this.listadoContactos)
          ],
        )),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, "/create");
            },
            label: Text("Crear Contacto")));
  }

  obtenerContactos() async {
    ContactProvider provider = ContactProvider();
    await provider.init();
    ContactResponseModel response = await provider.obternerContactos();

    List<Widget> contactosACargar = <Widget>[];
    for (int i = 0; i < response.listaContactos.length; i++) {
      Card card = Card(
        child: Column(
          children: [
            Text(response.listaContactos[i].nombre +
                " " +
                response.listaContactos[i].apellidos),
            Text(response.listaContactos[i].telefono),
            Text(response.listaContactos[i].email)
          ],
        ),
      );
      contactosACargar.add(card);
    }
    setState(() {
      this.listadoContactos = contactosACargar;
    });
  }
}
