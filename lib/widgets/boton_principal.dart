import 'package:flutter/material.dart';

// Componente reutilizable para los botones principales de la app.
// Asegura que todos los botones de "Entrar", "Guardar", etc. tengan el mismo estilo.
class BotonPrincipal extends StatelessWidget {
  final String texto; // El texto que mostrará el botón
  final VoidCallback onPressed; // La función (callback) que se ejecuta al pulsar

  const BotonPrincipal({
    super.key,
    required this.texto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        width: double.infinity, // Hace que el botón ocupe todo el ancho disponible
        child: ElevatedButton(
          onPressed: onPressed, // Asocia la acción recibida
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: Text(texto),
        ),
      ),
    );
  }
}