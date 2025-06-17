import 'package:flutter/material.dart';

class Juego6Screen extends StatelessWidget {
  const Juego6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎨 Creatividad'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'Aquí va el juego de Creatividad',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
