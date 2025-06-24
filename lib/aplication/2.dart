import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neuroplay/export.dart';

class Juego2Screen extends StatefulWidget {
  const Juego2Screen({super.key});

  @override
  State<Juego2Screen> createState() => _Juego2ScreenState();
}

class _Juego2ScreenState extends State<Juego2Screen> {
  final Random _random = Random();

  final List<int> _sequence = [];
  final List<int> _playerInput = [];

  final List<Color> _colors = [
    AppColors.verdeSuave,
    AppColors.rosadoSuave,
    AppColors.amarilloSuave,
    AppColors.orange,
    AppColors.lilaSuave,
    const Color.fromARGB(255, 235, 141, 117),
  ];

  bool _isShowingSequence = false;
  int _score = 0;

  bool _isMounted = true; // <- NUEVO

  @override
  void initState() {
    super.initState();
    _isMounted = true; // <- asegúrate que es true
    _startNewGame();
  }

  @override
  void dispose() {
    _isMounted = false; // <- cuando se destruye
    super.dispose();
  }

  void _startNewGame() {
    _score = 0;
    _generateNewSequence();
  }

  void _generateNewSequence() {
    _sequence.clear();
    _playerInput.clear();

    for (int i = 0; i < 3; i++) {
      _sequence.add(_random.nextInt(_colors.length));
    }

    _showSequence();
  }

  Future<void> _showSequence() async {
    if (!_isMounted) return; // seguridad
    setState(() {
      _isShowingSequence = true;
    });

    await Future.delayed(const Duration(milliseconds: 2500));

    if (!_isMounted) return; // seguridad
    setState(() {
      _isShowingSequence = false;
    });
  }

  void _handlePlayerTap(int index) {
    if (_isShowingSequence) return;

    setState(() {
      _playerInput.add(index);
    });

    int currentStep = _playerInput.length - 1;

    if (_playerInput[currentStep] != _sequence[currentStep]) {
      _showErrorAndRestart();
    } else if (_playerInput.length == _sequence.length) {
      setState(() {
        _score++;
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (!_isMounted) return; // seguridad
        _generateNewSequence();
      });
    }
  }

  Future<void> _showErrorAndRestart() async {
    if (!_isMounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 1),
        content: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: const Text(
              '❌',
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 1700));
    if (!_isMounted) return;
    _generateNewSequence();
  }

  Color _getBallColor(int index) {
    if (_isShowingSequence) {
      return _colors[_sequence[index]];
    } else {
      if (index < _playerInput.length) {
        return _colors[_sequence[index]];
      } else {
        return Colors.grey[300]!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tu build original no cambia
      backgroundColor: AppColors.segundo,
      appBar: AppBar(
        backgroundColor: AppColors.segundo,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primero,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.tercero),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text('🧠 Memoria'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_sequence.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _getBallColor(index),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          Text(
            'Puntaje: $_score',
            style: TextStyle(
              fontSize: 24,
              color: AppColors.primero,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(_colors.length, (index) {
              return GestureDetector(
                onTap: () => _handlePlayerTap(index),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: _colors[index],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
