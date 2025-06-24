import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:neuroplay/export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: AppColors.primero,
      foregroundColor: AppColors.tercero,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.segundo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'NEUROPLAY',
              style: TextStyle(
                color: AppColors.tercero,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 50),

            // Botón INICIAR
            SizedBox(
              width: 250, // ⬅️ Más ancho
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.pushNamed(context, '/juego');
                },
                child: const Text('INICIAR'),
              ),
            ),
            const SizedBox(height: 20),

            // Botón MINI JUEGOS
            SizedBox(
              width: 250,
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.pushNamed(context, '/mini');
                },
                child: const Text('MINI JUEGOS'),
              ),
            ),
            const SizedBox(height: 20),

            // Botón AYUDA
            SizedBox(
              width: 250,
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WebViewScreen(
                        url: 'https://tutorialazo.com/politica-de-privacidad-para-aplicaciones-moviles-de-tutorialazo/',
                        title: 'Política de Privacidad',
                      ),
                    ),
                  );
                },
                child: const Text('AYUDA'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
