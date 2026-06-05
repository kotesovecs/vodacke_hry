import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/content.dart';
import '../theme.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen>
    with SingleTickerProviderStateMixin {
  final _rng = Random();
  late final AnimationController _controller;
  String? _result;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _roll() {
    HapticFeedback.mediumImpact();
    final who = diceWho[_rng.nextInt(diceWho.length)];
    final what = diceWhat[_rng.nextInt(diceWhat.length)];
    setState(() => _result = '$who $what');
    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    return Scaffold(
      appBar: AppBar(title: const Text('Kostka osudu')),
      extendBodyBehindAppBar: true,
      body: FireBackground(
        glow: AppColors.ember,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: result == null
                        ? const _DicePlaceholder()
                        : ScaleTransition(
                            scale: Tween<double>(begin: 0.85, end: 1.0).animate(
                              CurvedAnimation(
                                parent: _controller,
                                curve: Curves.easeOutBack,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('🎲',
                                    style: TextStyle(fontSize: 64)),
                                const SizedBox(height: 24),
                                Text(
                                  result,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    height: 1.3,
                                    fontWeight: FontWeight.w900,
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
                    onPressed: _roll,
                    icon: const Icon(Icons.casino),
                    label: Text(result == null ? 'Hodit kostkou' : 'Hodit znovu'),
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

class _DicePlaceholder extends StatelessWidget {
  const _DicePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text('🎲', style: TextStyle(fontSize: 80)),
        SizedBox(height: 18),
        Text(
          'Hoď kostkou a osud rozhodne,\nkdo si přihne!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            height: 1.3,
            color: AppColors.textHi,
          ),
        ),
      ],
    );
  }
}
