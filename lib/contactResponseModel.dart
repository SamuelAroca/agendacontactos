import 'package:agenda_contactos/contactModel.dart';

class ContactResponseModel {
  List<ContactModel> listaContactos = <ContactModel>[];

  ContactResponseModel.empty() {
    this.listaContactos = List.empty();
  }

  ContactResponseModel.fromDB(List<Map> resultadosQuery) {
    for (int i = 0; i < resultadosQuery.length; i++) {
      ContactModel contact = ContactModel(resultadosQuery[i]);
      this.listaContactos.add(contact);
    }
  }
}
