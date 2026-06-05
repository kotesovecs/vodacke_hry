import 'dart:math';

import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme.dart';

class DrinkRulesScreen extends StatefulWidget {
  const DrinkRulesScreen({super.key});

  @override
  State<DrinkRulesScreen> createState() => _DrinkRulesScreenState();
}

class _DrinkRulesScreenState extends State<DrinkRulesScreen> {
  late List<String> _order;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    _order = List<String>.from(drinkRules)..shuffle(Random());
    _index = 0;
  }

  void _next() {
    setState(() {
      if (_index < _order.length - 1) {
        _index++;
      } else {
        _shuffle();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rule = _order[_index];
    return Scaffold(
      appBar: AppBar(title: const Text('Pij když…')),
      extendBodyBehindAppBar: true,
      body: FireBackground(
        glow: AppColors.gold,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Karta ${_index + 1} / ${_order.length}',
                  style: const TextStyle(color: AppColors.textLo),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: ScaleTransition(scale: anim, child: child),
                      ),
                      child: Column(
                        key: ValueKey(rule),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 7),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              'PRAVIDLO 🍺',
                              style: TextStyle(
                                color: AppColors.gold,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 26),
                          Text(
                            rule,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              height: 1.3,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textHi,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.night,
                    ),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Další pravidlo'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
