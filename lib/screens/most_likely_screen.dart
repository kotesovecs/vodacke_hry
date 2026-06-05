import 'dart:math';

import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme.dart';

class MostLikelyScreen extends StatefulWidget {
  const MostLikelyScreen({super.key});

  @override
  State<MostLikelyScreen> createState() => _MostLikelyScreenState();
}

class _MostLikelyScreenState extends State<MostLikelyScreen> {
  late List<String> _order;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    _order = List<String>.from(mostLikely)..shuffle(Random());
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
    final question = _order[_index];
    return Scaffold(
      appBar: AppBar(title: const Text('Kdo z nás nejspíš…')),
      extendBodyBehindAppBar: true,
      body: FireBackground(
        glow: AppColors.river,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Otázka ${_index + 1} / ${_order.length}',
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
                        key: ValueKey(question),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.how_to_vote,
                              size: 52, color: AppColors.river),
                          const SizedBox(height: 24),
                          Text(
                            question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              height: 1.25,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textHi,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Na 3 všichni ukažte prstem!',
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
                      backgroundColor: AppColors.river,
                      foregroundColor: AppColors.night,
                    ),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Další otázka'),
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
