import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:neuroplay/export.dart';

class Juego4Screen extends StatefulWidget {
  const Juego4Screen({super.key});

  @override
  State<Juego4Screen> createState() => _Juego4ScreenState();
}

class _Juego4ScreenState extends State<Juego4Screen> {
  final Random _random = Random();

  int _sequenceType = 0;
  int _numberBase = 1;
  int _vowelBase = 0;

  List<String> _correctSequence = [];
  List<String> _currentSequence = [];

  final List<String> _vowels = ['A', 'E', 'I', 'O', 'U'];
  final List<String> _dayIcons = ['🌞', '🌇', '🌙'];

  @override
  void initState() {
    super.initState();
    _generateSequence();
  }

  void _generateSequence() {
    switch (_sequenceType) {
      case 0:
        // Números consecutivos
        _correctSequence = List.generate(4, (i) => (_numberBase + i).toString());
        break;
      case 1:
        // Vocales consecutivas
        if (_vowelBase + 4 > _vowels.length) {
          _vowelBase = 0; // reiniciar si pasa del final
        }
        _correctSequence = _vowels.sublist(_vowelBase, _vowelBase + 4);
        break;
      case 2:
        _correctSequence = List.from(_dayIcons);
        break;
    }
    _currentSequence = List.from(_correctSequence);
    _currentSequence.shuffle();
    setState(() {});
  }

  void _onAccept(int index, String data) {
    setState(() {
      final oldIndex = _currentSequence.indexOf(data);
      final temp = _currentSequence[index];
      _currentSequence[index] = data;
      _currentSequence[oldIndex] = temp;
    });

    _verifyAuto();
  }

  Future<void> _verifyAuto() async {
    if (_currentSequence.join() == _correctSequence.join()) {
      if (_sequenceType == 0) {
        _numberBase++;
      } else if (_sequenceType == 1) {
        _vowelBase++;
        if (_vowelBase + 4 > _vowels.length) {
          _vowelBase = 0;
        }
      }
      _sequenceType = (_sequenceType + 1) % 3;
      await Future.delayed(const Duration(milliseconds: 400));
      _generateSequence();
    }
  }

  Widget _buildImage(String label, bool isCorrect) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isCorrect ? AppColors.cuarto : Colors.blue[100],
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (_sequenceType) {
      case 0:
        return 'NÚMEROS';
      case 1:
        return 'VOCALES';
      case 2:
        return 'DÍA';
      default:
        return '';
    }
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
        title: const Text('✋ Secuencias'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            _getTitle(),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_currentSequence.length, (index) {
                    final item = _currentSequence[index];
                    final isCorrect = item == _correctSequence[index];
                    return DragTarget<String>(
                      onAccept: (data) => _onAccept(index, data),
                      builder: (context, candidateData, rejectedData) {
                        return Draggable<String>(
                          data: item,
                          feedback: _buildImage(item, isCorrect),
                          childWhenDragging: Opacity(
                            opacity: 0.4,
                            child: _buildImage(item, isCorrect),
                          ),
                          child: _buildImage(item, isCorrect),
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
