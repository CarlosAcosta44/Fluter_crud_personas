import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/persona_controller.dart';
import '../models/persona_model.dart';

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
      final newPersona = PersonaModel(
        id: widget.persona?.id,
        identificacion: identificacionCtrl.text,
        nombre: nombreCtrl.text,
        apellido: apellidoCtrl.text,
        email: emailCtrl.text,
        telefono: telefonoCtrl.text.isNotEmpty ? telefonoCtrl.text : null,
        direccion: direccionCtrl.text.isNotEmpty ? direccionCtrl.text : null,
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
              TextFormField(
                controller: identificacionCtrl,
                decoration: const InputDecoration(labelText: 'Identificación'),
                readOnly: isEditing,
                validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: apellidoCtrl,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (!GetUtils.isEmail(value)) return 'Email inválido';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: telefonoCtrl,
                decoration: const InputDecoration(labelText: 'Teléfono (Opcional)'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: direccionCtrl,
                decoration: const InputDecoration(labelText: 'Dirección (Opcional)'),
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
