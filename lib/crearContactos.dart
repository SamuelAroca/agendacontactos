import 'package:agenda_contactos/contactModel.dart';
import 'package:agenda_contactos/contactProvider.dart';
import 'package:flutter/material.dart';

class CrearContactos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CrearContactos();
  }
}

class _CrearContactos extends State<CrearContactos> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String nombre = "";
  String apellidos = "";
  String email = "";
  String telefono = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Crear Contacto")),
        body: Container(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              obtenerCampoNombre(),
              obtenerCampoApellidos(),
              obtenerCampoEmail(),
              obtenerCampoTelefono(),
              obtenerBotonGuardar()
            ],
          ),
        )));
  }

  TextFormField obtenerCampoNombre() {
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: "Nombre del contacto"),
        validator: (value) {
          if (value!.length > 0) {
            return null;
          } else {
            return "El nombre no puede ser vacío";
          }
        },
        onSaved: (value) {
          this.nombre = value!;
        });
  }

  TextFormField obtenerCampoApellidos() {
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: "Apellidos del contacto"),
        validator: (value) {
          if (value!.length > 0) {
            return null;
          } else {
            return "Los apellidos no pueden ser vacíos";
          }
        },
        onSaved: (value) {
          this.apellidos = value!;
        });
  }

  TextFormField obtenerCampoTelefono() {
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: "Teléfono del contacto"),
        validator: (value) {
          if (value!.length >= 7 && value!.length <= 10) {
            return null;
          } else {
            return "Verifique el número de teléfono";
          }
        },
        onSaved: (value) {
          this.telefono = value!;
        });
  }

  TextFormField obtenerCampoEmail() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(labelText: "Email del contacto"),
        validator: (value) {
          if (value!.length > 0) {
            return null;
          } else {
            return "Verifique el email del contacto";
          }
        },
        onSaved: (value) {
          this.email = value!;
        });
  }

  ElevatedButton obtenerBotonGuardar() {
    return ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            crearContacto();
            Navigator.pop(context);
          }
        },
        child: Text("Guardar Nuevo Contacto"));
  }

  crearContacto() async {
    ContactModel contact =
        ContactModel.fromValues("", nombre, apellidos, email, telefono);
    ContactProvider provider = ContactProvider();
    await provider.init();

    var id = await provider.agregarContacto(contact);
  }
}
