import 'package:flutter/material.dart';
import '../widgets/campo_texto_app.dart';
import '../widgets/boton_principal.dart';
import 'registro_screen.dart';
import 'habitos_screen.dart';

// Pantalla de inicio de sesión.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para leer el usuario y la contraseña
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    // Liberamos los controladores para no consumir memoria
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _login() {
    // Simulación en memoria
    // Si el usuario es 'admin' y la clave '1234', entramos.
    if (_userController.text == 'admin' && _passController.text == '1234') {
      // pushReplacement para que al darle "Atrás" no vuelva al login
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HabitosScreen()));
    } else {
      // Si falla, mostramos un mensaje de error abajo (SnackBar)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuario o contraseña incorrectos (Usa admin/1234)')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Usamos nuestro componente de campo de texto
            CampoTextoApp(label: 'Usuario', controller: _userController),
            CampoTextoApp(label: 'Contraseña', controller: _passController, ocultarContenido: true),
            // Usamos nuestro botón principal
            BotonPrincipal(texto: 'Entrar', onPressed: _login),
            // Botón de texto para ir al registro
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegistroScreen()));
              },
              child: const Text('¿No tienes cuenta? Regístrate'),
            )
          ],
        ),
      ),
    );
  }
}