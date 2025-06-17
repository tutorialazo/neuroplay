import 'package:flutter/material.dart';

class Juego2Screen extends StatelessWidget {
  const Juego2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧠 Memoria'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'Aquí va el juego de Memoria',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
