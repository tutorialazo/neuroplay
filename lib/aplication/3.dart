import 'dart:math';
import 'package:flutter/material.dart';
import 'package:neuroplay/export.dart';

class Juego3Screen extends StatefulWidget {
  const Juego3Screen({super.key});

  @override
  State<Juego3Screen> createState() => _Juego3ScreenState();
}

class _Juego3ScreenState extends State<Juego3Screen> {
  final List<Color> _categories = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
  ];

  final Random _random = Random();

  List<_FigureItem> _figures = [];

  int _score = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _generateFigures());
  }

  void _generateFigures() {
    final Size screen = MediaQuery.of(context).size;
    final double availableWidth = screen.width - 100;
    final double availableHeight = screen.height * 0.5;

    List<_FigureItem> generated = [];

    while (generated.length < 5) {
      final color = _categories[_random.nextInt(_categories.length)];
      final shapes = ['circle', 'square', 'triangle'];
      final shape = shapes[_random.nextInt(shapes.length)];

      final dx = _random.nextDouble() * availableWidth;
      final dy = _random.nextDouble() * availableHeight;

      final newItem = _FigureItem(
        shape: shape,
        color: color,
        id: UniqueKey().toString(),
        x: dx,
        y: dy,
      );

      // Evitar superposición con radio mínimo
      bool overlaps = generated.any((other) {
        double distance = sqrt(pow(newItem.x - other.x, 2) + pow(newItem.y - other.y, 2));
        return distance < 80; // Distancia mínima entre centros
      });

      if (!overlaps) {
        generated.add(newItem);
      }
    }

    _figures = generated;
    setState(() {});
  }

  void _handleCorrectDrop(String figureId) {
    setState(() {
      _figures.removeWhere((fig) => fig.id == figureId);
      _score++;
    });

    if (_figures.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _generateFigures();
      });
    }
  }

  void _updateFigurePosition(String id, Offset offset) {
    setState(() {
      final index = _figures.indexWhere((f) => f.id == id);
      if (index != -1) {
        _figures[index] = _figures[index].copyWith(
          x: offset.dx,
          y: offset.dy,
        );
      }
    });
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
        title: const Text('🔵 Clasificar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Puntaje: $_score',
            style: TextStyle(
              fontSize: 24,
              color: AppColors.primero,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _categories.map((color) {
              return DragTarget<_FigureItem>(
                onWillAccept: (item) => item?.color == color,
                onAccept: (item) => _handleCorrectDrop(item.id),
                builder: (context, candidate, rejected) {
                  return Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.5),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.inbox, size: 50),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: _figures.map((figure) {
                return Positioned(
                  left: figure.x,
                  top: figure.y,
                  child: Draggable<_FigureItem>(
                    data: figure,
                    feedback: _buildFigure(figure),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: _buildFigure(figure),
                    ),
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        _updateFigurePosition(
                          figure.id,
                          Offset(
                            figure.x + details.delta.dx,
                            figure.y + details.delta.dy,
                          ),
                        );
                      },
                      child: _buildFigure(figure),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFigure(_FigureItem item) {
    return Container(
      width: 70,
      height: 70,
      decoration: ShapeDecoration(
        color: item.color,
        shape: _getShape(item.shape),
      ),
    );
  }

  ShapeBorder _getShape(String shape) {
    switch (shape) {
      case 'square':
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
      case 'triangle':
        return const _TriangleShape();
      case 'circle':
      default:
        return const CircleBorder();
    }
  }
}

class _FigureItem {
  final String shape;
  final Color color;
  final String id;
  final double x;
  final double y;

  _FigureItem({
    required this.shape,
    required this.color,
    required this.id,
    required this.x,
    required this.y,
  });

  _FigureItem copyWith({double? x, double? y}) {
    return _FigureItem(
      shape: shape,
      color: color,
      id: id,
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }
}

class _TriangleShape extends ShapeBorder {
  const _TriangleShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    path.moveTo(rect.center.dx, rect.top);
    path.lineTo(rect.right, rect.bottom);
    path.lineTo(rect.left, rect.bottom);
    path.close();
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
