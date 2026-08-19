import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/persona_model.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/personas';

  Future<List<PersonaModel>> getPersonas() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        return list.map((model) => PersonaModel.fromJson(model)).toList();
      } else {
        throw Exception('Error al cargar personas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Excepción al cargar personas: $e');
    }
  }

  Future<PersonaModel> getPersonaById(String identificacion) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$identificacion'));
      if (response.statusCode == 200) {
        return PersonaModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al cargar persona: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Excepción al cargar persona: $e');
    }
  }

  Future<bool> createPersona(PersonaModel persona) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(persona.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePersona(int id, PersonaModel persona) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(persona.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePersona(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
