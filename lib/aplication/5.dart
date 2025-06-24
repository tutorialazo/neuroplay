import 'dart:math';
import 'package:flutter/material.dart';
import 'package:neuroplay/export.dart';

class Juego5Screen extends StatefulWidget {
  const Juego5Screen({super.key});

  @override
  State<Juego5Screen> createState() => _Juego5ScreenState();
}

class _PuzzlePiece {
  final int id;
  _PuzzlePiece({required this.id});
}

class _Juego5ScreenState extends State<Juego5Screen> {
  final int gridSize = 2; // 2x2 puzzle
  late List<_PuzzlePiece> pieces;

  @override
  void initState() {
    super.initState();
    _generatePuzzle();
  }

  void _generatePuzzle() {
    pieces = List.generate(gridSize * gridSize, (index) => _PuzzlePiece(id: index));
    pieces.shuffle();
    setState(() {});
  }

  void _handleDrop(int targetIndex, _PuzzlePiece piece) {
    setState(() {
      int currentIndex = pieces.indexOf(piece);
      final temp = pieces[targetIndex];
      pieces[targetIndex] = piece;
      pieces[currentIndex] = temp;
    });

    if (_isSolved()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎉 ¡Figura completada!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _generatePuzzle();
              },
              child: const Text('Nuevo Puzzle'),
            ),
          ],
        ),
      );
    }
  }

  bool _isSolved() {
    // Verifica que cada pieza esté en la celda correcta:
    for (int i = 0; i < pieces.length; i++) {
      if (pieces[i].id != i) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double pieceSize = MediaQuery.of(context).size.width / gridSize - 20;

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
        title: const Text('🧩 Lógica'),
        centerTitle: true,
      ),
      body: Center(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(gridSize * gridSize, (index) {
            return DragTarget<_PuzzlePiece>(
              onWillAccept: (_) => true,
              onAccept: (piece) => _handleDrop(index, piece),
              builder: (context, candidate, rejected) {
                final piece = pieces[index];
                // El índice de la celda es el targetIndex
                final isCorrect = piece.id == index;
                return Draggable<_PuzzlePiece>(
                  data: piece,
                  feedback: Container(
                    width: pieceSize,
                    height: pieceSize,
                    decoration: BoxDecoration(
                      color: isCorrect ? Colors.green[300] : AppColors.tercero,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: CustomPaint(
                      painter: _CircleQuarterPainter(piece.id),
                    ),
                  ),
                  childWhenDragging: Container(
                    width: pieceSize,
                    height: pieceSize,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Container(
                    width: pieceSize,
                    height: pieceSize,
                    decoration: BoxDecoration(
                      color: isCorrect ? Colors.green[300] : AppColors.tercero,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: CustomPaint(
                      painter: _CircleQuarterPainter(piece.id),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

class _CircleQuarterPainter extends CustomPainter {
  final int quarterId;

  _CircleQuarterPainter(this.quarterId);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Usa el mismo tamaño que la card para que no se desborde:
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final startAngle = quarterId * pi / 2;
    canvas.drawArc(rect, startAngle, pi / 2, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

