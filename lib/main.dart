import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/preferences_service.dart';

void main() {
  runApp(const HabitosApp());
}

class HabitosApp extends StatefulWidget {
  const HabitosApp({super.key});

  @override
  State<HabitosApp> createState() => _HabitosAppState();
}

class _HabitosAppState extends State<HabitosApp> {
  final PreferenciasService _prefs = PreferenciasService();

  // Estados para el tema y tamaño de letra
  bool _cargando = true;
  bool _temaOscuro = false;
  double _tamanoLetra = 1.0;

  @override
  void initState() {
    super.initState();
    _inicializar();
  }

  Future<void> _inicializar() async {
    // Registramos la apertura y leemos los ajustes (igual que antes)
    await _prefs.registrarApertura();
    final tema = await _prefs.leerTemaOscuro();
    final tamano = await _prefs.leerTamanoLetra();

    if (!mounted) return;
    setState(() {
      _temaOscuro = tema;
      _tamanoLetra = tamano;
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      // Puedes usar tu propio LoadingWidget o un CircularProgressIndicator
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp(
      title: 'HabitosApp',
      debugShowCheckedModeBanner: false,
      // MANTENEMOS EL TEMA OSCURO
      themeMode: _temaOscuro ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(_tamanoLetra),
          ),
          child: child!,
        );
      },
      //Arranca en el Login
      home: const LoginScreen(),
    );
  }
}