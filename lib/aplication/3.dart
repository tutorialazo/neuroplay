import 'package:flutter/material.dart';

class Juego3Screen extends StatelessWidget {
  const Juego3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔵 Clasificar'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'Aquí va el juego de Clasificar',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
