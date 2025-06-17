import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Juego1Screen extends StatefulWidget {
  const Juego1Screen({super.key});

  @override
  State<Juego1Screen> createState() => _Juego1ScreenState();
}

class _Juego1ScreenState extends State<Juego1Screen> {
  final Random _random = Random();
  double _x = 100;
  double _y = 100;
  int _score = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Mover el círculo cada segundo
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _moveTarget();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _moveTarget() {
    final screenSize = MediaQuery.of(context).size;

    setState(() {
      // Nueva posición aleatoria dentro de la pantalla, dejando márgenes
      _x = _random.nextDouble() * (screenSize.width - 100);
      _y = _random.nextDouble() * (screenSize.height - 200); // restar AppBar y margen
    });
  }

  void _incrementScore() {
    setState(() {
      _score++;
    });
    // Mover de inmediato después de tocar
    _moveTarget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🟢 Atención'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Puntaje arriba
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Puntos: $_score',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Círculo verde movible
          Positioned(
            left: _x,
            top: _y,
            child: GestureDetector(
              onTap: _incrementScore,
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
