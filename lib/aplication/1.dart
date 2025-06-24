import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neuroplay/export.dart';

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

  // Colores tomados de tu paleta
  final List<Color> _colors = [
    AppColors.orange, 
    const Color.fromARGB(255, 233, 137, 250),
    const Color.fromARGB(255, 235, 223, 117),
    AppColors.verdeSuave,
    AppColors.lilaSuave,
    AppColors.rosadoSuave,
    AppColors.amarilloSuave,
  ];

  // Color fijo para toda la sesión
  late Color _currentColor;

  @override
  void initState() {
    super.initState();

    // Elegir color aleatorio UNA VEZ al iniciar
    _currentColor = _colors[_random.nextInt(_colors.length)];

    // Mover el círculo cada 2.8 segundos
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (timer) {
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

    const double circleSize = 80;  // tamaño real de la bolita
    const double safeTop = 80;     // espacio superior (puntaje)
    const double safeBottom = 40;  // margen inferior para barra de navegación

    setState(() {
      _x = _random.nextDouble() * (screenSize.width - circleSize);
      _y = safeTop + _random.nextDouble() * (screenSize.height - safeTop - safeBottom - circleSize);
    });
  }

  void _incrementScore() {
    setState(() {
      _score++;
    });
    _moveTarget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.segundo,
      appBar: AppBar(
        backgroundColor: AppColors.segundo,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primero,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.tercero,
                size: 28,
              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: const Text('🟢 Atención'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Puntaje arriba a la izquierda
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Puntos: $_score',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primero,
              ),
            ),
          ),
          // Círculo tocable con color de tu paleta
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
