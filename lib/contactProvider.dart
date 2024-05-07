import 'dart:io';

import 'package:agenda_contactos/contactModel.dart';
import 'package:agenda_contactos/contactResponseModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactProvider {
  Database? db;

  ContactProvider();

  init() async {
    Directory appFolder = await getApplicationDocumentsDirectory();

    var fullPath = join(appFolder.path, "Contacts.db");

    this.db =
        await openDatabase(fullPath, onCreate: (Database newDb, int version) {
      return newDb.execute("""
          CREATE TABLE Contactos
          (_id TEXT,
          nombre TEXT,
          apellidos TEXT,
          email TEXT,
          telefono TEXT,
          sincronizado TEXT);
        """);
    }, version: 5);
  }

  Future<ContactResponseModel> obternerContactos() async {
    var results = await this.db!.rawQuery("""
                  SELECT * FROM Contactos ORDER BY apellidos, nombre
                  """);
    ContactResponseModel response = ContactResponseModel.fromDB(results);
    return response;
  }

  Future<void> agregarContacto(ContactModel contacto) async {
    await this.db!.rawInsert("""
          INSERT INTO Contactos (_id, nombre, apellidos, email, telefono, sincronizado)
          VALUES ( ?, ?, ?, ?, ?, ?) """, [
      contacto.id,
      contacto.nombre,
      contacto.apellidos,
      contacto.email,
      contacto.telefono,
      contacto.sincronizado
    ]);
  }

  Future<ContactResponseModel> obternerContactosPendientesSincronizar() async {
    var results = await this.db!.rawQuery("""
                  SELECT * FROM Contactos WHERE sincronizado == '0'
                  """);
    ContactResponseModel response = ContactResponseModel.fromDB(results);
    return response;
  }

  Future<void> marcarContactosSincronizados() async {
    await this.db!.rawUpdate("""
    UPDATE Contactos SET sincronizado = '1'
    """);
  }
}
