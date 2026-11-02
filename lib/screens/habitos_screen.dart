import 'package:flutter/material.dart';
import '../widgets/tarjeta_habito.dart';
import 'editar_habito_screen.dart';
import 'login_screen.dart';

// Pantalla principal donde se muestran los hábitos del usuario.
class HabitosScreen extends StatefulWidget {
  const HabitosScreen({super.key});
  @override
  State<HabitosScreen> createState() => _HabitosScreenState();
}

class _HabitosScreenState extends State<HabitosScreen> {
  // Lista en memoria con un hábito de ejemplo (como pide la entrega de hoy)
  final List<Map<String, dynamic>> _habitos = [
    {'nombre': 'Beber agua', 'color': Colors.blue, 'completado': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Mis Hábitos'),
          actions: [
            // Botón para cerrar sesión y volver al login
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                }
            )
          ]
      ),
      // Si la lista está vacía, mostramos un mensaje. Si no, la lista de tarjetas.
      body: _habitos.isEmpty
          ? const Center(child: Text('No hay hábitos. ¡Crea uno!'))
          : ListView.builder(
        itemCount: _habitos.length,
        itemBuilder: (context, index) {
          final h = _habitos[index];
          // Usamos el componente reutilizable TarjetaHabito
          return TarjetaHabito(
            nombre: h['nombre'],
            color: h['color'],
            completadoHoy: h['completado'],
            // Callback para completar/desmarcar
            onCompletar: () {
              setState(() {
                _habitos[index]['completado'] = !_habitos[index]['completado'];
              });
            },
            // Callback para editar
            onEditar: () async {
              // Abrimos la pantalla de edición pasándole los datos actuales
              final resultado = await Navigator.push<Map<String, dynamic>>(
                context,
                MaterialPageRoute(
                  builder: (_) => EditarHabitoScreen(nombreInicial: h['nombre'], colorInicial: h['color']),
                ),
              );
              // Si el resultado no es nulo (el usuario guardó), actualizamos la lista
              if (resultado != null) {
                setState(() {
                  _habitos[index]['nombre'] = resultado['nombre'];
                  _habitos[index]['color'] = resultado['color'];
                });
              }
            },
            // Callback para eliminar
            onEliminar: () {
              setState(() {
                _habitos.removeAt(index);
              });
            },
          );
        },
      ),
      // Botón flotante para crear un hábito nuevo
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Abrimos el editor sin datos iniciales (crear)
          final resultado = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(builder: (_) => const EditarHabitoScreen()),
          );
          // Si guardó, añadimos el nuevo hábito a la lista
          if (resultado != null) {
            setState(() {
              _habitos.add({'nombre': resultado['nombre'], 'color': resultado['color'], 'completado': false});
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}