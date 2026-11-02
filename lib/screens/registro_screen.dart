import 'package:flutter/material.dart';
import '../widgets/campo_texto_app.dart';
import '../widgets/boton_principal.dart';

// Pantalla de registro de un nuevo usuario.
class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});
  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  // Controladores para todos los campos que pide el formulario
  final _userController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _nombreController.dispose();
    _apellidosController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _registrar() {
    // Simulación de registro exitoso
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registro exitoso. Inicia sesión.')));
    // Volvemos al login usando Navigator.pop
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      // SingleChildScrollView para que la pantalla se pueda desplazar si el teclado la tapa
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CampoTextoApp(label: 'Usuario', controller: _userController),
            CampoTextoApp(label: 'Nombre', controller: _nombreController),
            CampoTextoApp(label: 'Apellidos', controller: _apellidosController),
            CampoTextoApp(label: 'Email', controller: _emailController),
            // El campo de contraseña tiene ocultarContenido = true
            CampoTextoApp(label: 'Contraseña', controller: _passController, ocultarContenido: true),
            BotonPrincipal(texto: 'Registrarse', onPressed: _registrar),
          ],
        ),
      ),
    );
  }
}