import 'package:flutter/material.dart';
import '../models/persona_model.dart';

class PersonaDetailView extends StatelessWidget {
  final PersonaModel persona;

  const PersonaDetailView({Key? key, required this.persona}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Persona'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('ID en BD', persona.id?.toString() ?? 'N/A'),
                const Divider(),
                _buildDetailRow('Identificación', persona.identificacion),
                const Divider(),
                _buildDetailRow('Nombre', persona.nombre),
                const Divider(),
                _buildDetailRow('Apellido', persona.apellido),
                const Divider(),
                _buildDetailRow('Email', persona.email),
                const Divider(),
                _buildDetailRow('Teléfono', persona.telefono ?? 'No registrado'),
                const Divider(),
                _buildDetailRow('Dirección', persona.direccion ?? 'No registrada'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
