import 'package:flutter/material.dart';

// Componente reutilizable para mostrar un dato estadístico
class DatoEstadistica extends StatelessWidget {
  final String etiqueta; // Texto descriptivo
  final String valor; // El valor numérico en texto
  final IconData icono; // Icono representativo
  final Color color; // Color del icono (opcional, por defecto azul)

  const DatoEstadistica({
    super.key,
    required this.etiqueta,
    required this.valor,
    required this.icono,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icono, color: color, size: 30),
        const SizedBox(height: 8),
        Text(valor, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(etiqueta, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}