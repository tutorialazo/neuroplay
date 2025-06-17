import 'package:flutter/material.dart';

class Juego4Screen extends StatelessWidget {
  const Juego4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('✋ Secuencias'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'Aquí va el juego de Secuencias',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
