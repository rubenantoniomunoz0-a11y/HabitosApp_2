import 'package:flutter/material.dart';

// Componente reutilizable para los campos de texto.
// Nos evita repetir el mismo diseño de TextField en todas las pantallas.
class CampoTextoApp extends StatelessWidget {
  final String label; // Texto de la etiqueta (ej. "Usuario")
  final TextEditingController controller; // Controlador para leer lo que escribe el usuario
  final bool ocultarContenido; // Si es true, oculta el texto (útil para contraseñas)

  const CampoTextoApp({
    super.key,
    required this.label,
    required this.controller,
    this.ocultarContenido = false, // Por defecto, el texto se ve normal
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Separación arriba y abajo
      child: TextField(
        controller: controller,
        obscureText: ocultarContenido, // Aplica el ocultamiento si es contraseña
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(), // Borde cuadrado alrededor del campo
        ),
      ),
    );
  }
}