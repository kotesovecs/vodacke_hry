import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../data/content.dart';
import '../theme.dart';
import '../widgets/party_banner.dart';

class HeadsUpScreen extends StatefulWidget {
  const HeadsUpScreen({super.key});

  @override
  State<HeadsUpScreen> createState() => _HeadsUpScreenState();
}

enum _Phase { pickDeck, countdown, playing, done }

class _HeadsUpScreenState extends State<HeadsUpScreen> {
  _Phase _phase = _Phase.pickDeck;
  String? _deckName;
  int _roundSeconds = 90;

  late List<String> _words;
  int _wordIndex = 0;
  final List<MapEntry<String, bool>> _results = []; // slovo, uhodnuto?
  int _remaining = 0;
  int _countdown = 3;

  Timer? _gameTimer;
  Timer? _countdownTimer;
  StreamSubscription<AccelerometerEvent>? _accelSub;
  bool _neutral = true; // čeká na návrat do svislé polohy
  bool _locked = false; // krátká pauza po vyhodnocení

  @override
  void dispose() {
    _gameTimer?.cancel();
    _countdownTimer?.cancel();
    _accelSub?.cancel();
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void _pickDeck(String name) {
    setState(() {
      _deckName = name;
      _phase = _Phase.countdown;
      _countdown = 3;
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    WakelockPlus.enable();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_countdown <= 1) {
        _countdownTimer?.cancel();
        _startRound();
      } else {
        setState(() => _countdown--);
      }
    });
  }

  void _startRound() {
    final deck = List<String>.from(headsUpDecks[_deckName]!)..shuffle(Random());
    setState(() {
      _words = deck;
      _wordIndex = 0;
      _results.clear();
      _remaining = _roundSeconds;
      _phase = _Phase.playing;
    });
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining <= 1) {
        _finish();
      } else {
        setState(() => _remaining--);
      }
    });
    _listenTilt();
  }

  void _listenTilt() {
    // V ležaté poloze na čele je telefon svisle (gravitace podél osy y).
    // Naklonění obrazovkou dolů (k zemi) => z roste; nahoru (k nebi) => z klesá.
    _accelSub = accelerometerEventStream().listen((e) {
      if (_phase != _Phase.playing || _locked) return;
      final z = e.z;
      if (z.abs() < 3.5) {
        _neutral = true; // telefon se vrátil do svislé polohy
        return;
      }
      if (!_neutral) return;
      if (z > 7.5) {
        _neutral = false;
        _register(true); // sklopení dolů = uhodnuto
      } else if (z < -7.5) {
        _neutral = false;
        _register(false); // zaklonění nahoru = další/neznám
      }
    });
  }

  void _register(bool correct) {
    HapticFeedback.mediumImpact();
    _results.add(MapEntry(_words[_wordIndex], correct));
    setState(() {
      _locked = true;
      if (_wordIndex < _words.length - 1) {
        _wordIndex++;
      } else {
        _words.shuffle(Random());
        _wordIndex = 0;
      }
    });
    // krátká pauza, ať se stihne telefon vrátit do svislé polohy
    Timer(const Duration(milliseconds: 700), () {
      if (mounted) setState(() => _locked = false);
    });
  }

  void _finish() {
    _gameTimer?.cancel();
    _accelSub?.cancel();
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setState(() => _phase = _Phase.done);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          _phase == _Phase.pickDeck ? AppBar(title: const Text('Kdo jsem?')) : null,
      extendBodyBehindAppBar: true,
      body: FireBackground(
        glow: AppColors.gold,
        child: SafeArea(
          child: switch (_phase) {
            _Phase.pickDeck => _buildPickDeck(),
            _Phase.countdown => _buildCountdown(),
            _Phase.playing => _buildPlaying(),
            _Phase.done => _buildDone(),
          },
        ),
      ),
    );
  }

  Widget _buildPickDeck() {
    final names = headsUpDecks.keys.toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              '📱 Telefon si dáš na čelo (displejem k ostatním). '
              'Ostatní ti hrají/popisují slovo.\n\n'
              '⬇️ Sklopíš dolů = UHODL\n'
              '⬆️ Zakloníš nahoru = DALŠÍ',
              style: TextStyle(color: AppColors.textHi, height: 1.4),
            ),
          ),
          const SizedBox(height: 14),
          const PartyBanner(
            text: 'Hádající pije za každé neuhodnuté slovo!',
            margin: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),
          const Text('Délka kola',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHi)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: [60, 90, 120].map((s) {
              final sel = _roundSeconds == s;
              return ChoiceChip(
                label: Text('$s s'),
                selected: sel,
                onSelected: (_) => setState(() => _roundSeconds = s),
                selectedColor: AppColors.gold,
                backgroundColor: AppColors.nightCard,
                labelStyle: TextStyle(
                  color: sel ? AppColors.night : AppColors.textHi,
                  fontWeight: FontWeight.w700,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 22),
          const Text('Vyber balíček',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHi)),
          const SizedBox(height: 12),
          ...names.map((name) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _pickDeck(name),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.nightCard,
                      foregroundColor: AppColors.textHi,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.style, color: AppColors.gold),
                        const SizedBox(width: 14),
                        Text(name),
                        const Spacer(),
                        Text('${headsUpDecks[name]!.length}',
                            style: const TextStyle(color: AppColors.textLo)),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCountdown() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Dej si telefon na čelo!',
              style: TextStyle(fontSize: 22, color: AppColors.textHi)),
          const SizedBox(height: 24),
          Text('$_countdown',
              style: const TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.w900,
                  color: AppColors.gold)),
        ],
      ),
    );
  }

  Widget _buildPlaying() {
    final correct = _results.where((r) => r.value).length;
    final Color bg;
    if (_locked && _results.isNotEmpty) {
      bg = _results.last.value
          ? AppColors.leaf.withValues(alpha: 0.4)
          : AppColors.rose.withValues(alpha: 0.4);
    } else {
      bg = Colors.transparent;
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      color: bg,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                _locked && _results.isNotEmpty
                    ? (_results.last.value ? 'SPRÁVNĚ ✅' : 'DALŠÍ ⏭️')
                    : _words[_wordIndex],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 64,
                  height: 1.1,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textHi,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 20,
            child: Text('⏱️ $_remaining',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gold)),
          ),
          Positioned(
            top: 8,
            right: 20,
            child: Text('✅ $correct',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.leaf)),
          ),
          Positioned(
            bottom: 6,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: _finish,
                child: const Text('Ukončit',
                    style: TextStyle(color: AppColors.textLo)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDone() {
    final correct = _results.where((r) => r.value).length;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const Text('🎉', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 8),
          Text('$correct',
              style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  color: AppColors.gold)),
          const Text('uhodnutých',
              style: TextStyle(color: AppColors.textLo, fontSize: 16)),
          const SizedBox(height: 20),
          if (_results.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: AppColors.nightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: _results
                    .map((r) => ListTile(
                          dense: true,
                          leading: Icon(
                            r.value ? Icons.check_circle : Icons.cancel,
                            color: r.value ? AppColors.leaf : AppColors.rose,
                          ),
                          title: Text(r.key,
                              style: const TextStyle(color: AppColors.textHi)),
                        ))
                    .toList(),
              ),
            ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => setState(() => _phase = _Phase.pickDeck),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.night,
            ),
            icon: const Icon(Icons.replay),
            label: const Text('Hrát znovu'),
          ),
        ],
      ),
    );
  }
}
