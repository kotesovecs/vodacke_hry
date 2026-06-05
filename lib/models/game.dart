import 'package:flutter/material.dart';

/// Popis jedné minihry pro hlavní menu (herní krabici).
class GameInfo {
  const GameInfo({
    required this.title,
    required this.tagline,
    required this.icon,
    required this.color,
    required this.builder,
    this.drinking = false,
  });

  final String title;
  final String tagline;
  final IconData icon;
  final Color color;
  final WidgetBuilder builder;

  /// Pijácká hra – v menu se ukáže jen v párty režimu.
  final bool drinking;
}
