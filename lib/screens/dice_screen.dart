import 'dart:async';
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

class _DiceScreenState extends State<DiceScreen> {
  final _rng = Random();
  Timer? _rollTimer;

  String? _result;
  int _face = 1;
  int _lastFace = -1;
  bool _rolling = false;

  @override
  void dispose() {
    _rollTimer?.cancel();
    super.dispose();
  }

  int _pickFace() {
    int next;
    do {
      next = _rng.nextInt(6) + 1;
    } while (next == _lastFace);
    return next;
  }

  void _roll() {
    if (_rolling) return;
    HapticFeedback.mediumImpact();

    final finalFace = _pickFace();
    var ticks = 0;
    const totalTicks = 14;

    setState(() {
      _rolling = true;
      _result = null;
    });

    _rollTimer?.cancel();
    _rollTimer = Timer.periodic(const Duration(milliseconds: 70), (timer) {
      ticks++;
      setState(() => _face = _rng.nextInt(6) + 1);

      if (ticks >= totalTicks) {
        timer.cancel();
        HapticFeedback.lightImpact();
        final who = diceWho[_rng.nextInt(diceWho.length)];
        final what = diceWhat[_rng.nextInt(diceWhat.length)];
        setState(() {
          _face = finalFace;
          _lastFace = finalFace;
          _result = '$who $what';
          _rolling = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    return Scaffold(
      appBar: AppBar(title: const Text('Kostka')),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedScale(
                          scale: _rolling ? 1.06 : 1.0,
                          duration: const Duration(milliseconds: 70),
                          curve: Curves.easeOut,
                          child: _StaticDice(value: _face),
                        ),
                        const SizedBox(height: 28),
                        if (_rolling)
                          const Text(
                            'Hod probíhá...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textHi,
                            ),
                          )
                        else if (result != null)
                          Text(
                            result,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              height: 1.3,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textHi,
                            ),
                          )
                        else
                          const Text(
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
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _rolling ? null : _roll,
                    icon: const Text('🎲', style: TextStyle(fontSize: 20)),
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

/// Statická kostka – čtverec s puntíky podle čísla.
class _StaticDice extends StatelessWidget {
  const _StaticDice({required this.value});
  final int value;
  static const double size = 128;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFCF7), Color(0xFFF0E6D6), Color(0xFFE4D8C8)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.ember.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0x33000000), width: 1.5),
      ),
      child: CustomPaint(
        painter: _DiceFacePainter(value),
      ),
    );
  }
}

class _DiceFacePainter extends CustomPainter {
  _DiceFacePainter(this.value);
  final int value;

  static const _layouts = {
    1: [Offset(0.5, 0.5)],
    2: [Offset(0.28, 0.28), Offset(0.72, 0.72)],
    3: [Offset(0.28, 0.28), Offset(0.5, 0.5), Offset(0.72, 0.72)],
    4: [
      Offset(0.28, 0.28),
      Offset(0.72, 0.28),
      Offset(0.28, 0.72),
      Offset(0.72, 0.72),
    ],
    5: [
      Offset(0.28, 0.28),
      Offset(0.72, 0.28),
      Offset(0.5, 0.5),
      Offset(0.28, 0.72),
      Offset(0.72, 0.72),
    ],
    6: [
      Offset(0.28, 0.24),
      Offset(0.72, 0.24),
      Offset(0.28, 0.5),
      Offset(0.72, 0.5),
      Offset(0.28, 0.76),
      Offset(0.72, 0.76),
    ],
  };

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width * 0.09;
    for (final uv in _layouts[value] ?? const []) {
      final center = Offset(uv.dx * size.width, uv.dy * size.height);
      final isOne = value == 1;

      canvas.drawCircle(
        center + Offset(r * 0.08, r * 0.12),
        r * 1.05,
        Paint()
          ..color = Colors.black.withValues(alpha: 0.25)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
      );

      canvas.drawCircle(
        center,
        r,
        Paint()
          ..color = isOne ? const Color(0xFF8B1510) : const Color(0xFF141010),
      );

      if (isOne) {
        canvas.drawCircle(
          center + Offset(r * 0.03, r * 0.05),
          r * 0.85,
          Paint()..color = const Color(0xFF5A0A08),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_DiceFacePainter old) => old.value != value;
}
