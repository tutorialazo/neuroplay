import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detectar orientación
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('🎮 NeuroPlay'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: isLandscape ? 3 : 2, // ✅ 3 columnas en horizontal
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: isLandscape ? 1.3 : 0.9, // ✅ ratio dinámico
          children: [
            _buildGameCard(
              context,
              emoji: '🟢',
              title: 'Atención',
              onTap: () {
                Navigator.pushNamed(context, '/juego1');
              },
            ),
            _buildGameCard(
              context,
              emoji: '🧠',
              title: 'Memoria',
              onTap: () {
                Navigator.pushNamed(context, '/juego2');
              },
            ),
            _buildGameCard(
              context,
              emoji: '🔵',
              title: 'Clasificar',
              onTap: () {
                Navigator.pushNamed(context, '/juego3');
              },
            ),
            _buildGameCard(
              context,
              emoji: '✋',
              title: 'Secuencias',
              onTap: () {
                Navigator.pushNamed(context, '/juego4');
              },
            ),
            _buildGameCard(
              context,
              emoji: '🧩',
              title: 'Lógica',
              onTap: () {
                Navigator.pushNamed(context, '/juego5');
              },
            ),
            _buildGameCard(
              context,
              emoji: '🎨',
              title: 'Creatividad',
              onTap: () {
                Navigator.pushNamed(context, '/juego6');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context, {
    required String emoji,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
