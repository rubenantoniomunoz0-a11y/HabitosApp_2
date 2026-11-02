import 'package:flutter/material.dart';
import '../widgets/campo_texto_app.dart';
import '../widgets/boton_principal.dart';

// Pantalla para crear o editar un hábito.
// Si recibe nombreInicial, está editando. Si no, está creando.
class EditarHabitoScreen extends StatefulWidget {
  final String? nombreInicial;
  final Color? colorInicial;
  const EditarHabitoScreen({super.key, this.nombreInicial, this.colorInicial});

  @override
  State<EditarHabitoScreen> createState() => _EditarHabitoScreenState();
}

class _EditarHabitoScreenState extends State<EditarHabitoScreen> {
  late TextEditingController _nombreController;
  late Color _colorSeleccionado;

  @override
  void initState() {
    super.initState();
    // Inicializamos el controlador con el nombre que venía (o vacío si es nuevo)
    _nombreController = TextEditingController(text: widget.nombreInicial ?? '');
    _colorSeleccionado = widget.colorInicial ?? Colors.blue; // Color por defecto
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  void _guardar() {
    final nuevoNombre = _nombreController.text.trim();
    if (nuevoNombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('El nombre no puede estar vacío')));
      return;
    }
    // Devolvemos los datos a la pantalla anterior usando Navigator.pop
    Navigator.pop(context, {'nombre': nuevoNombre, 'color': _colorSeleccionado});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nombreInicial == null ? 'Crear Hábito' : 'Editar Hábito')),
      // SingleChildScrollView por si el teclado tapa los botones
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de texto usando el componente reutilizable
            CampoTextoApp(label: 'Nombre del hábito', controller: _nombreController),
            const SizedBox(height: 24),
            const Text('Selecciona un color:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            // Fila con los 3 botones de colores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _botonColor(Colors.blue),
                _botonColor(Colors.green),
                _botonColor(Colors.orange),
              ],
            ),
            const SizedBox(height: 32),
            // Botón de guardar usando el componente
            BotonPrincipal(texto: 'Guardar', onPressed: _guardar),
            // Botón de cancelar (devuelve null, por lo que no se actualiza nada)
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Método auxiliar para crear los círculos de colores
  Widget _botonColor(Color color) {
    return GestureDetector(
      onTap: () => setState(() => _colorSeleccionado = color),
      child: Container(
        width: 50, height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          // Si este color es el seleccionado, le ponemos un borde negro
          border: Border.all(color: _colorSeleccionado == color ? Colors.black : Colors.transparent, width: 3),
        ),
      ),
    );
  }
}