import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/persona_model.dart';
import '../services/api_service.dart';

class PersonaController extends GetxController {
  final ApiService _apiService = ApiService();
  
  RxList<PersonaModel> personas = <PersonaModel>[].obs;
  RxBool isLoading = false.obs;
  
  var selectedPhotoBase64 = Rxn<String>();
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        final base64String = 'data:image/jpeg;base64,${base64Encode(bytes)}';
        selectedPhotoBase64.value = base64String;
      }
    } catch (e) {
      print("Error al capturar foto: $e");
      Get.snackbar(
        'Aviso',
        'No se pudo acceder a la fuente seleccionada. Selecciona una imagen desde el explorador de archivos.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPersonas();
  }

  Future<void> fetchPersonas() async {
    isLoading.value = true;
    try {
      final data = await _apiService.getPersonas();
      personas.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar las personas',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPersona(PersonaModel persona) async {
    isLoading.value = true;
    try {
      bool success = await _apiService.createPersona(persona);
      if (success) {
        await fetchPersonas();
        Get.back();
        Get.snackbar('Éxito', 'Persona agregada correctamente',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'No se pudo agregar la persona',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editPersona(int id, PersonaModel persona) async {
    isLoading.value = true;
    try {
      bool success = await _apiService.updatePersona(id, persona);
      if (success) {
        await fetchPersonas();
        Get.back();
        Get.snackbar('Éxito', 'Persona actualizada correctamente',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'No se pudo actualizar la persona',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removePersona(int id) async {
    isLoading.value = true;
    try {
      bool success = await _apiService.deletePersona(id);
      if (success) {
        await fetchPersonas();
        Get.snackbar('Éxito', 'Persona eliminada correctamente',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'No se pudo eliminar la persona',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
