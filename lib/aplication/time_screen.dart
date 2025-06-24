import 'package:flutter/material.dart';
import 'package:neuroplay/export.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  final List<int> times = [5, 10];
  int? selectedTime;

  final List<_LevelItem> levels = [
    _LevelItem(
      name: 'Montaña',
      imageUrl: 'https://picsum.photos/id/1018/200/300',
      description: 'Un paisaje montañoso que inspira calma.',
      videoUrl: 'https://example.com/videos/montana.mp4',
    ),
    _LevelItem(
      name: 'Río',
      imageUrl: 'https://picsum.photos/id/1015/200/300',
      description: 'Un río tranquilo que fluye suavemente.',
      videoUrl: 'https://example.com/videos/rio.mp4',
    ),
    _LevelItem(
      name: 'Cañón',
      imageUrl: 'https://picsum.photos/id/1016/200/300',
      description: 'Un cañón amplio para explorar con la mente.',
      videoUrl: 'https://example.com/videos/canon.mp4',
    ),
    _LevelItem(
      name: 'Lago',
      imageUrl: 'https://picsum.photos/id/1011/200/300',
      description: 'Un lago sereno bajo el cielo claro.',
      videoUrl: 'https://example.com/videos/lago.mp4',
    ),
    _LevelItem(
      name: 'Meditación',
      imageUrl: 'https://picsum.photos/id/1025/200/300',
      description: 'Un espacio de paz para meditar.',
      videoUrl: 'https://example.com/videos/meditacion.mp4',
    ),
    _LevelItem(
      name: 'Oso',
      imageUrl: 'https://picsum.photos/id/1020/200/300',
      description: 'La fuerza y calma de un oso en la naturaleza.',
      videoUrl: 'https://example.com/videos/oso.mp4',
    ),
    _LevelItem(
      name: 'Águila',
      imageUrl: 'https://picsum.photos/id/1024/200/300',
      description: 'El vuelo libre de un águila vigilante.',
      videoUrl: 'https://example.com/videos/aguila.mp4',
    ),
  ];

  int? selectedLevel;

  @override
  Widget build(BuildContext context) {
    final isReady = selectedTime != null && selectedLevel != null;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: AppColors.primero,
      foregroundColor: AppColors.tercero,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );

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
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // === RESPIRACIONES ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.primero,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RESPIRACIONES:',
                    style: TextStyle(
                      color: AppColors.tercero,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '5',
                    style: TextStyle(
                      color: AppColors.tercero,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // === TIEMPO DE JUEGO ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.primero,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TIEMPO DE JUEGO:',
                    style: TextStyle(
                      color: AppColors.tercero,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(times.length, (index) {
                      final t = times[index];
                      final isSelected = selectedTime == t;

                      return Padding(
                        padding: EdgeInsets.only(right: index < times.length - 1 ? 8.0 : 0),
                        child: ElevatedButton(
                          style: buttonStyle.copyWith(
                            backgroundColor: WidgetStateProperty.all(
                              isSelected ? AppColors.segundo : AppColors.tercero,
                            ),
                            foregroundColor: WidgetStateProperty.all(AppColors.primero),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedTime = t;
                            });
                          },
                          child: Text('$t'),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),

            // === ELIGE TU NIVEL ===
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.primero,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'ESCOGE UN NIVEL:',
                          style: TextStyle(
                            color: AppColors.tercero,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        if (selectedLevel != null)
                          Text(
                            levels[selectedLevel!].name,
                            style: TextStyle(
                              color: AppColors.tercero,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        itemCount: levels.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2 / 3,
                        ),
                        itemBuilder: (context, index) {
                          final isSelected = selectedLevel == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLevel = index;
                              });
                            },
                            child: ColorFiltered(
                              colorFilter: isSelected
                                  ? const ColorFilter.mode(
                                      Colors.transparent, BlendMode.multiply)
                                  : const ColorFilter.matrix(<double>[
                                      0.2126, 0.7152, 0.0722, 0, 0,
                                      0.2126, 0.7152, 0.0722, 0, 0,
                                      0.2126, 0.7152, 0.0722, 0, 0,
                                      0, 0, 0, 1, 0,
                                    ]),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected ? AppColors.tercero : Colors.transparent,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(levels[index].imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // === BOTÓN EMPEZAR ===
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: buttonStyle.copyWith(
                  backgroundColor: WidgetStateProperty.all(
                    isReady ? AppColors.primero : AppColors.tercero,
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    isReady ? AppColors.tercero : AppColors.primero,
                  ),
                ),
                onPressed: isReady
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/loadinggame',
                          arguments: {
                            'time': selectedTime,
                            'levelUrl': levels[selectedLevel!].imageUrl,
                            'levelName': levels[selectedLevel!].name,
                            'levelDescription': levels[selectedLevel!].description,
                            'levelVideo': levels[selectedLevel!].videoUrl, // 🚀 NUEVO 🚀
                          },
                        );
                      }
                    : null,
                child: const Text('INICIAR JUEGO'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelItem {
  final String name;
  final String imageUrl;
  final String description;
  final String videoUrl;

  _LevelItem({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.videoUrl,
  });
}
