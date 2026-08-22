import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/persona_controller.dart';
import '../models/persona_model.dart';
import '../validations/persona_validator.dart';

class PersonaFormView extends StatefulWidget {
  final PersonaModel? persona;

  const PersonaFormView({Key? key, this.persona}) : super(key: key);

  @override
  State<PersonaFormView> createState() => _PersonaFormViewState();
}

class _PersonaFormViewState extends State<PersonaFormView> {
  final PersonaController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController identificacionCtrl;
  late TextEditingController nombreCtrl;
  late TextEditingController apellidoCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController telefonoCtrl;
  late TextEditingController direccionCtrl;

  bool get isEditing => widget.persona != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      controller.selectedPhotoBase64.value = widget.persona?.fotoPerfil;
    } else {
      controller.selectedPhotoBase64.value = null;
    }
    identificacionCtrl = TextEditingController(text: widget.persona?.identificacion ?? '');
    nombreCtrl = TextEditingController(text: widget.persona?.nombre ?? '');
    apellidoCtrl = TextEditingController(text: widget.persona?.apellido ?? '');
    emailCtrl = TextEditingController(text: widget.persona?.email ?? '');
    telefonoCtrl = TextEditingController(text: widget.persona?.telefono ?? '');
    direccionCtrl = TextEditingController(text: widget.persona?.direccion ?? '');
  }

  @override
  void dispose() {
    identificacionCtrl.dispose();
    nombreCtrl.dispose();
    apellidoCtrl.dispose();
    emailCtrl.dispose();
    telefonoCtrl.dispose();
    direccionCtrl.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final photoVal = controller.selectedPhotoBase64.value;
      print('Enviando foto: ${photoVal != null && photoVal.length > 30 ? photoVal.substring(0, 30) : photoVal}...');
      final newPersona = PersonaModel(
        id: widget.persona?.id,
        identificacion: identificacionCtrl.text.trim(),
        nombre: nombreCtrl.text.trim(),
        apellido: apellidoCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        telefono: telefonoCtrl.text.trim().isNotEmpty ? telefonoCtrl.text.trim() : null,
        direccion: direccionCtrl.text.trim().isNotEmpty ? direccionCtrl.text.trim() : null,
        fotoPerfil: controller.selectedPhotoBase64.value ?? (isEditing ? widget.persona?.fotoPerfil : null),
      );

      if (isEditing) {
        controller.editPersona(newPersona.id!, newPersona);
      } else {
        controller.addPersona(newPersona);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Persona' : 'Nueva Persona'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => controller.showImageSourceDialog(),
                child: Column(
                  children: [
                    Obx(() {
                      final photoBase64 = controller.selectedPhotoBase64.value;
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: photoBase64 != null && photoBase64.isNotEmpty
                            ? MemoryImage(base64Decode(photoBase64.contains(',') ? photoBase64.split(',').last : photoBase64))
                            : null,
                        child: photoBase64 == null || photoBase64.isEmpty
                            ? const Icon(Icons.camera_alt, size: 40)
                            : null,
                      );
                    }),
                    const SizedBox(height: 8),
                    const Text(
                      'Subir/Tomar Foto',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: identificacionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Identificación (10 dígitos)',
                  hintText: 'Ej: 1033721059',
                ),
                keyboardType: TextInputType.number,
                maxLength: 10,
                readOnly: isEditing,
                validator: PersonaValidator.validateIdentificacion,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: PersonaValidator.validateNombre,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: apellidoCtrl,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: PersonaValidator.validateApellido,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: PersonaValidator.validateEmail,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: telefonoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Teléfono (Opcional)',
                  hintText: 'Ej: 3144317548',
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: PersonaValidator.validateTelefono,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: direccionCtrl,
                decoration: const InputDecoration(labelText: 'Dirección (Opcional)'),
                validator: PersonaValidator.validateDireccion,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : _saveForm,
                  child: controller.isLoading.value 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Guardar'),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
