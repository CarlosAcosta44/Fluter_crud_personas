class PersonaModel {
  int? id;
  String identificacion;
  String nombre;
  String apellido;
  String email;
  String? telefono;
  String? direccion;

  PersonaModel({
    this.id,
    required this.identificacion,
    required this.nombre,
    required this.apellido,
    required this.email,
    this.telefono,
    this.direccion,
  });

  factory PersonaModel.fromJson(Map<String, dynamic> json) {
    return PersonaModel(
      id: json['id'],
      identificacion: json['identificacion'] ?? '',
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      email: json['email'] ?? '',
      telefono: json['telefono'],
      direccion: json['direccion'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'identificacion': identificacion,
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
    };
    if (id != null) data['id'] = id;
    if (telefono != null) data['telefono'] = telefono;
    if (direccion != null) data['direccion'] = direccion;
    return data;
  }
}
