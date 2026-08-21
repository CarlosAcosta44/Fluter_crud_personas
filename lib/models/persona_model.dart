class PersonaModel {
  int? id;
  String identificacion;
  String nombre;
  String apellido;
  String email;
  String? telefono;
  String? direccion;
  final String? fotoPerfil;

  PersonaModel({
    this.id,
    required this.identificacion,
    required this.nombre,
    required this.apellido,
    required this.email,
    this.telefono,
    this.direccion,
    this.fotoPerfil,
  });

  factory PersonaModel.fromJson(Map<String, dynamic> json) => PersonaModel(
    id: json['id'],
    identificacion: json['identificacion'] ?? '',
    nombre: json['nombre'] ?? '',
    apellido: json['apellido'] ?? '',
    email: json['email'] ?? '',
    telefono: json['telefono'],
    direccion: json['direccion'],
    fotoPerfil: json['foto_perfil'],
  );

  Map<String, dynamic> toJson() => {
    'identificacion': identificacion,
    'nombre': nombre,
    'apellido': apellido,
    'email': email,
    'telefono': telefono,
    'direccion': direccion,
    'foto_perfil': fotoPerfil,
  };
}

