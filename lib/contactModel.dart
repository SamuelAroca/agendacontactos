class ContactModel {
  String id = "";
  String nombre = "";
  String apellidos = "";
  String email = "";
  String telefono = "";
  String sincronizado = "";

  // Constructor 1: Crea un CM a partir de un JSON
  ContactModel(Map json) {
    this.id = json["_id"];
    this.nombre = json["nombre"];
    this.apellidos = json["apellidos"];
    this.email = json["email"];
    this.telefono = json["telefono"];
    this.sincronizado =
        json["sincronizado"] == null ? "" : json["sincronizado"];
  }

  // Constructor 2: Crear un CM a partir de los valores individuales
  ContactModel.fromValues(String id, String nombre, String apellidos,
      String email, String telefono, String sincronizado) {
    this.id = id;
    this.nombre = nombre;
    this.apellidos = apellidos;
    this.email = email;
    this.telefono = telefono;
    this.sincronizado = sincronizado;
  }
}
