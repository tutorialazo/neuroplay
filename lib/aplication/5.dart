import 'package:flutter/material.dart';

class Juego5Screen extends StatelessWidget {
  const Juego5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧩 Lógica'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'Aquí va el juego de Lógica',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
