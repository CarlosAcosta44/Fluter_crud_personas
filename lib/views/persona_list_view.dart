import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/persona_controller.dart';
import 'persona_form_view.dart';
import 'persona_detail_view.dart';

class PersonaListView extends StatelessWidget {
  const PersonaListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PersonaController controller = Get.put(PersonaController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Personas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchPersonas(),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.personas.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.personas.isEmpty) {
          return const Center(child: Text('No hay personas registradas'));
        }

        return ListView.builder(
          itemCount: controller.personas.length,
          itemBuilder: (context, index) {
            final persona = controller.personas[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: (persona.fotoPerfil != null && persona.fotoPerfil!.isNotEmpty)
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(base64Decode(persona.fotoPerfil!)),
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                title: Text('${persona.nombre} ${persona.apellido}'),
                subtitle: Text('ID: ${persona.identificacion}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.info, color: Colors.blue),
                      onPressed: () => Get.to(() => PersonaDetailView(persona: persona)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => Get.to(() => PersonaFormView(persona: persona)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Confirmación',
                          middleText: '¿Estás seguro de eliminar a ${persona.nombre}?',
                          textConfirm: 'Eliminar',
                          textCancel: 'Cancelar',
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            Get.back();
                            if (persona.id != null) {
                              controller.removePersona(persona.id!);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(() => const PersonaFormView()),
      ),
    );
  }
}
