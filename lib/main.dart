import 'package:flutter/material.dart';
import 'package:neuroplay/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NeuroplayApp());
}

class NeuroplayApp extends StatelessWidget {
  const NeuroplayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neuroplay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        // Flujo inicial
        '/': (context) => const SplashScreen(),

        // Navegación principal con BottomNavBar
        '/home': (context) => const HomeScreen(),

        //Juegos
        '/juego': (context) => const TimeScreen(),
        '/loadinggame': (context) => const LoadingScreen(),

        //Mini
        '/mini': (context) => const MinigamesScreen(),
        '/juego1': (context) => const Juego1Screen(),
        '/juego2': (context) => const Juego2Screen(),
        '/juego3': (context) => const Juego3Screen(),
        '/juego4': (context) => const Juego4Screen(),
        
      },
    );
  }
}
