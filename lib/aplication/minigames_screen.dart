import 'package:flutter/material.dart';
import 'package:neuroplay/export.dart';

class MinigamesScreen extends StatelessWidget {
  const MinigamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

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
        title: const Text('🎮 ELIGE UNO'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: isLandscape ? 3 : 2, 
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: isLandscape ? 1.3 : 0.9,
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
