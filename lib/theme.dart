import 'package:flutter/material.dart';

/// Barevná paleta „u ohně" – tmavé pozadí, žhavé oranžové a zlaté akcenty.
/// Cíl: dobře čitelné potmě, velká písmena, vysoký kontrast.
class AppColors {
  static const Color night = Color(0xFF140E0A); // skoro černá, do hněda
  static const Color nightCard = Color(0xFF24190F); // karty
  static const Color nightCardHi = Color(0xFF312314); // zvýrazněná karta
  static const Color ember = Color(0xFFFF7A33); // žhavá oranžová
  static const Color emberDeep = Color(0xFFE85D1E);
  static const Color gold = Color(0xFFFFC14D); // zlatý plamen
  static const Color spark = Color(0xFFFFE08A); // jiskra
  static const Color river = Color(0xFF4FC3D6); // vodácká modrozelená
  static const Color leaf = Color(0xFF8BC34A);
  static const Color rose = Color(0xFFFF6F8B);
  static const Color textHi = Color(0xFFFFF3E4);
  static const Color textLo = Color(0xFFC9B7A6);
}

ThemeData buildAppTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.ember,
    brightness: Brightness.dark,
  ).copyWith(
    primary: AppColors.ember,
    secondary: AppColors.gold,
    surface: AppColors.nightCard,
  );

  return base.copyWith(
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.night,
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.textHi,
      displayColor: AppColors.textHi,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      foregroundColor: AppColors.textHi,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
        color: AppColors.textHi,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.nightCard,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.ember,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.gold,
        side: const BorderSide(color: AppColors.gold, width: 1.5),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}

/// Pozadí s teplým „ohnivým" přechodem – použité na všech obrazovkách.
class FireBackground extends StatelessWidget {
  const FireBackground({super.key, required this.child, this.glow});

  final Widget child;

  /// Barva záře u spodního okraje (default oranžová). Každá hra si může
  /// nastavit vlastní, aby měla svou identitu.
  final Color? glow;

  @override
  Widget build(BuildContext context) {
    final glowColor = glow ?? AppColors.ember;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.night,
            const Color(0xFF1C130C),
            Color.alphaBlend(glowColor.withValues(alpha: 0.22), AppColors.night),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
      ),
      child: child,
    );
  }
}
