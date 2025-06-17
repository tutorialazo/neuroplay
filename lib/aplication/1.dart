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

  // Posición del círculo
  double _x = 100;
  double _y = 100;

  // Puntaje
  int _score = 0;

  // Timer para mover el círculo
  late Timer _timer;

  // Lista de colores posibles
  final List<Color> _colors = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
  ];

  // Color fijo para toda la sesión
  late Color _currentColor;

  @override
  void initState() {
    super.initState();

    // Elegir color aleatorio UNA VEZ al iniciar
    _currentColor = _colors[_random.nextInt(_colors.length)];

    // Mover el círculo cada 2 segundos
    _timer = Timer.periodic(const Duration(milliseconds: 2800), (timer) {
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
      // Solo cambiar posición
      _x = _random.nextDouble() * (screenSize.width - 100);
      _y = _random.nextDouble() * (screenSize.height - 200);
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
          // Puntaje en la esquina superior
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
          // Círculo movible con color FIJO
          Positioned(
            left: _x,
            top: _y,
            child: GestureDetector(
              onTap: _incrementScore,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _currentColor,
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
