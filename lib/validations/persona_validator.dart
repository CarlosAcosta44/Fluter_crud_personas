import 'package:get/get.dart';

class PersonaValidator {
  /// Validar campo de Identificación (requerido, solo números, exactamente 10 dígitos)
  static String? validateIdentificacion(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'La identificación es requerida';
    }
    if (!RegExp(r'^\d+$').hasMatch(trimmed)) {
      return 'La identificación debe contener solo números';
    }
    if (trimmed.length != 10) {
      return 'La identificación debe tener exactamente 10 dígitos';
    }
    return null;
  }

  /// Validar Nombre (requerido, mínimo 2 letras, solo caracteres alfabéticos)
  static String? validateNombre(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'El nombre es requerido';
    }
    if (trimmed.length < 2) {
      return 'El nombre debe tener al menos 2 caracteres';
    }
    if (!RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$").hasMatch(trimmed)) {
      return 'El nombre solo debe contener letras';
    }
    return null;
  }

  /// Validar Apellido (requerido, mínimo 2 letras, solo caracteres alfabéticos)
  static String? validateApellido(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'El apellido es requerido';
    }
    if (trimmed.length < 2) {
      return 'El apellido debe tener al menos 2 caracteres';
    }
    if (!RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$").hasMatch(trimmed)) {
      return 'El apellido solo debe contener letras';
    }
    return null;
  }

  /// Validar Email (requerido, formato de correo válido)
  static String? validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'El email es requerido';
    }
    if (!GetUtils.isEmail(trimmed)) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  /// Validar Teléfono (opcional, entre 7 y 10 dígitos si se ingresa)
  static String? validateTelefono(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return null; // Es opcional
    }
    if (!RegExp(r'^\d+$').hasMatch(trimmed)) {
      return 'El teléfono solo debe contener números';
    }
    if (trimmed.length < 7 || trimmed.length > 10) {
      return 'El teléfono debe tener entre 7 y 10 dígitos';
    }
    return null;
  }

  /// Validar Dirección (opcional, mínimo 5 caracteres si se ingresa)
  static String? validateDireccion(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return null; // Es opcional
    }
    if (trimmed.length < 5) {
      return 'La dirección debe tener al menos 5 caracteres';
    }
    return null;
  }
}
