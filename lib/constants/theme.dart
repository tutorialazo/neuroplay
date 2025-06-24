import 'package:flutter/material.dart';

class AppColors {
  static const Color primero = Color(0xFF2C3E50);
  static const Color segundo = Color(0xFFAEDFF7);
  static const Color tercero = Color(0xFFF0F3F5);
  static const Color cuarto = Color(0xFFA2D5AB);


  static const Color verdeSuave = Color.fromARGB(177, 93, 221, 116); // Verde pastel: relajación
  static const Color lilaSuave = Color.fromARGB(226, 181, 174, 223); // Lila claro: tranquilidad
  static const Color rosadoSuave = Color(0xFFF7C5CC); // Rosado pastel: calidez emocional
  static const Color amarilloSuave = Color(0xFFFFE79A); // Amarillo pastel: energía pero sin agresividad

  static const Color white = Color(0xFFFFFFFF);
  static const Color line = Color(0xFFEDEDED);
  static const Color black = Color(0xFF202226);
  static const Color gray1 = Color(0xFF838383);
  static const Color gray2 = Color(0xFFA2A5B1);
  static const Color cyan = Color(0xFF9DB2CE);
  static const Color critical = Color(0xFFEA3434);
  static const Color success = Color(0xFF44B461);
  static const Color gray = Color(0xFFE5E7EB);
  static const Color orange = Color.fromARGB(255, 252, 175, 104);
  static const Color facebookBlue = Color(0xFF1877F2);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primero,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
        titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        bodySmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
      ),
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primero,
        secondary: AppColors.orange,
        error: AppColors.critical,
        surface: AppColors.white,
        onPrimary: AppColors.white,
      ),
    );
  }

  // Si quieres un modo oscuro luego
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Poppins',
    );
  }
}
