import 'package:flutter/material.dart';

// Componente reutilizable que representa la tarjeta (ficha) de un hábito en la lista.
// Recibe todos los datos y las acciones (callbacks) para que la pantalla decida qué hacer.
class TarjetaHabito extends StatelessWidget {
  final String nombre;
  final Color color;
  final bool completadoHoy;
  final IconData icono; // Icono opcional (por defecto una estrella)
  final VoidCallback onCompletar; // Acción al marcar/desmarcar
  final VoidCallback onEditar; // Acción al pulsar editar
  final VoidCallback onEliminar; // Acción al pulsar eliminar

  const TarjetaHabito({
    super.key,
    required this.nombre,
    required this.color,
    required this.completadoHoy,
    this.icono = Icons.star, // Valor por defecto
    required this.onCompletar,
    required this.onEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        // Círculo de color a la izquierda con el icono
        leading: CircleAvatar(backgroundColor: color, child: Icon(icono, color: Colors.white)),
        // Nombre del hábito. Si está completado, se tacha el texto.
        title: Text(nombre, style: TextStyle(
          decoration: completadoHoy ? TextDecoration.lineThrough : null,
          fontWeight: FontWeight.bold,
        )),
        // Texto que indica si está pendiente o completado
        subtitle: Text(completadoHoy ? 'Completado hoy' : 'Pendiente'),
        // Botones de acción a la derecha (Completar, Editar, Eliminar)
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(completadoHoy ? Icons.check_circle : Icons.check_circle_outline, color: Colors.green),
              onPressed: onCompletar,
            ),
            IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: onEditar),
            IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: onEliminar),
          ],
        ),
      ),
    );
  }
}