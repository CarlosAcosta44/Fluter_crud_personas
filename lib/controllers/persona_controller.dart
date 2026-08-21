import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/persona_model.dart';
import '../services/api_service.dart';

class PersonaController extends GetxController {
  final ApiService _apiService = ApiService();
  
  RxList<PersonaModel> personas = <PersonaModel>[].obs;
  RxBool isLoading = false.obs;
  final Rx<String?> selectedPhotoBase64 = Rx<String?>(null);

  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 600,
    );
    if (image != null) {
      final bytes = await image.readAsBytes();
      selectedPhotoBase64.value = base64Encode(bytes);
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
