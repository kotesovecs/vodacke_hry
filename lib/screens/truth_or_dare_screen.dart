import 'dart:math';

import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme.dart';

class TruthOrDareScreen extends StatefulWidget {
  const TruthOrDareScreen({super.key});

  @override
  State<TruthOrDareScreen> createState() => _TruthOrDareScreenState();
}

class _TruthOrDareScreenState extends State<TruthOrDareScreen> {
  bool _spicy = false;
  final _rng = Random();
  DareCard? _current;

  List<DareCard> get _deck => _spicy ? dareSpicy : dareMild;

  void _draw(bool wantDare) {
    final pool = _deck.where((c) => c.isDare == wantDare).toList();
    setState(() => _current = pool[_rng.nextInt(pool.length)]);
  }

  @override
  Widget build(BuildContext context) {
    final card = _current;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pravda nebo úkol'),
        actions: [
          Row(
            children: [
              const Text('🌶️', style: TextStyle(fontSize: 16)),
              Switch(
                value: _spicy,
                activeColor: AppColors.rose,
                onChanged: (v) => setState(() {
                  _spicy = v;
                  _current = null;
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
                      child: card == null
                          ? const _Placeholder()
                          : _CardView(card: card, key: ValueKey(card.text)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _draw(false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.river,
                          foregroundColor: AppColors.night,
                        ),
                        child: const Text('PRAVDA'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _draw(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.rose,
                        ),
                        child: const Text('ÚKOL'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.local_fire_department, size: 56, color: AppColors.rose),
        SizedBox(height: 18),
        Text(
          'Vyber si: PRAVDA, nebo ÚKOL?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textHi,
          ),
        ),
      ],
    );
  }
}

class _CardView extends StatelessWidget {
  const _CardView({super.key, required this.card});

  final DareCard card;

  @override
  Widget build(BuildContext context) {
    final accent = card.isDare ? AppColors.rose : AppColors.river;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            card.isDare ? 'ÚKOL' : 'PRAVDA',
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 26),
        Text(
          card.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 27,
            height: 1.3,
            fontWeight: FontWeight.w800,
            color: AppColors.textHi,
          ),
        ),
      ],
    );
  }
}
