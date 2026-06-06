import 'dart:math';

import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme.dart';

class NeverHaveIEverScreen extends StatefulWidget {
  const NeverHaveIEverScreen({super.key});

  @override
  State<NeverHaveIEverScreen> createState() => _NeverHaveIEverScreenState();
}

class _NeverHaveIEverScreenState extends State<NeverHaveIEverScreen> {
  bool _spicy = false;
  late List<String> _order;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  List<String> get _deck => _spicy ? neverSpicy : neverMild;

  void _shuffle() {
    _order = List<String>.from(_deck)..shuffle(Random());
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
    final statement = _order[_index];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nikdy jsem'),
        actions: [
          Row(
            children: [
              const Text('🌶️', style: TextStyle(fontSize: 16)),
              Switch(
                value: _spicy,
                activeColor: AppColors.rose,
                onChanged: (v) => setState(() {
                  _spicy = v;
                  _shuffle();
                }),
              ),
            ],
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FireBackground(
        glow: AppColors.rose,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  _spicy ? 'Úroveň: pikantní 🌶️' : 'Úroveň: pohodová',
                  style: const TextStyle(color: AppColors.textLo),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 280),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: ScaleTransition(scale: anim, child: child),
                      ),
                      child: Column(
                        key: ValueKey(statement),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_bar,
                              size: 52, color: AppColors.rose),
                          const SizedBox(height: 24),
                          Text(
                            statement,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              height: 1.3,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textHi,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Kdo to udělal, pije! 🍺',
                            style: TextStyle(
                              color: AppColors.textLo,
                              fontSize: 15,
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
                      backgroundColor: AppColors.rose,
                    ),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Další'),
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
