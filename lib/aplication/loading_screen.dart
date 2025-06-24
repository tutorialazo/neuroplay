import 'package:flutter/material.dart';
import 'package:neuroplay/export.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Recibe todo, incluido el videoUrl
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String levelUrl = args['levelUrl'];
    final String levelName = args['levelName'];
    final String levelDescription = args['levelDescription'];
   final String videoUrl = args['levelVideo']; // correcto ahora
    final int time = args['time'];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Fondo imagen
          Image.network(
            levelUrl,
            fit: BoxFit.cover,
          ),

          // ✅ Capa oscura
          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          // ✅ Contenido
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Descripción
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      levelName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      levelDescription,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                // Botón continuar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tercero,
                      foregroundColor: AppColors.primero,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // ✅ Pasar también el videoUrl
                      Navigator.pushNamed(
                        context,
                        '/playing',
                        arguments: {
                          'time': time,
                          'levelUrl': levelUrl,
                          'videoUrl': videoUrl, // <-- nuevo
                        },
                      );
                    },
                    child: const Text('CONTINUAR'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
