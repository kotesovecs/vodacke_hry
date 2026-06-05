import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../data/content.dart';
import '../theme.dart';
import '../widgets/party_banner.dart';

class CharadesScreen extends StatefulWidget {
  const CharadesScreen({super.key});

  @override
  State<CharadesScreen> createState() => _CharadesScreenState();
}

enum _Phase { setup, playing, done }

class _CharadesScreenState extends State<CharadesScreen> {
  _Phase _phase = _Phase.setup;
  final Set<int> _selectedCats = {0};
  int _roundSeconds = 60;

  late List<String> _words;
  int _wordIndex = 0;
  int _correct = 0;
  int _skipped = 0;
  int _remaining = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  void _start() {
    final pool = <String>[];
    for (final i in _selectedCats) {
      pool.addAll(charadesCategories[i].words);
    }
    pool.shuffle(Random());
    setState(() {
      _words = pool;
      _wordIndex = 0;
      _correct = 0;
      _skipped = 0;
      _remaining = _roundSeconds;
      _phase = _Phase.playing;
    });
    WakelockPlus.enable();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining <= 1) {
        _finish();
      } else {
        setState(() => _remaining--);
      }
    });
  }

  void _finish() {
    _timer?.cancel();
    WakelockPlus.disable();
    setState(() => _phase = _Phase.done);
  }

  void _advance() {
    setState(() {
      if (_wordIndex < _words.length - 1) {
        _wordIndex++;
      } else {
        _words.shuffle(Random());
        _wordIndex = 0;
      }
    });
  }

  void _hit() {
    setState(() => _correct++);
    _advance();
  }

  void _skip() {
    setState(() => _skipped++);
    _advance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _phase == _Phase.playing
          ? null
          : AppBar(title: const Text('Aktivity')),
      extendBodyBehindAppBar: true,
      body: FireBackground(
        glow: AppColors.leaf,
        child: SafeArea(
          child: switch (_phase) {
            _Phase.setup => _buildSetup(),
            _Phase.playing => _buildPlaying(),
            _Phase.done => _buildDone(),
          },
        ),
      ),
    );
  }

  Widget _buildSetup() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Kategorie',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHi)),
          const SizedBox(height: 4),
          const Text('Vyber jednu nebo víc',
              style: TextStyle(color: AppColors.textLo)),
          const SizedBox(height: 12),
          ...List.generate(charadesCategories.length, (i) {
            final selected = _selectedCats.contains(i);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: selected
                    ? AppColors.leaf.withValues(alpha: 0.16)
                    : AppColors.nightCard,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => setState(() {
                    if (selected) {
                      if (_selectedCats.length > 1) _selectedCats.remove(i);
                    } else {
                      _selectedCats.add(i);
                    }
                  }),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selected ? AppColors.leaf : AppColors.nightCard,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: selected ? AppColors.leaf : AppColors.textLo,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(charadesCategories[i].name,
                              style: const TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textHi)),
                        ),
                        Text('${charadesCategories[i].words.length}',
                            style: const TextStyle(color: AppColors.textLo)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          const Text('Délka kola',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHi)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            children: [30, 60, 90, 120].map((s) {
              final sel = _roundSeconds == s;
              return ChoiceChip(
                label: Text('$s s'),
                selected: sel,
                onSelected: (_) => setState(() => _roundSeconds = s),
                selectedColor: AppColors.leaf,
                backgroundColor: AppColors.nightCard,
                labelStyle: TextStyle(
                  color: sel ? AppColors.night : AppColors.textHi,
                  fontWeight: FontWeight.w700,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _selectedCats.isEmpty ? null : _start,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.leaf,
                foregroundColor: AppColors.night,
              ),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Spustit kolo'),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Drž telefon tak, aby na slovo viděl jen předvádějící. '
            'Uhodnuté = ťukni vpravo, přeskoč = vlevo.',
            style: TextStyle(color: AppColors.textLo, fontSize: 13),
          ),
          const SizedBox(height: 14),
          const PartyBanner(
            text: 'Za každé přeskočené slovo lok na konci kola!',
            margin: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaying() {
    final lowTime = _remaining <= 10;
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          '$_remaining',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: lowTime ? AppColors.rose : AppColors.gold,
          ),
        ),
        Text('✅ $_correct    ⏭️ $_skipped',
            style: const TextStyle(color: AppColors.textLo, fontSize: 16)),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: Text(
                  _words[_wordIndex],
                  key: ValueKey(_wordIndex),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 46,
                    height: 1.15,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textHi,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 86,
                  child: ElevatedButton(
                    onPressed: _skip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.nightCard,
                      foregroundColor: AppColors.textLo,
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.skip_next, size: 30),
                        Text('Přeskoč'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 86,
                  child: ElevatedButton(
                    onPressed: _hit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.leaf,
                      foregroundColor: AppColors.night,
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, size: 34),
                        Text('Mám to!'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextButton(
            onPressed: _finish,
            child: const Text('Ukončit kolo',
                style: TextStyle(color: AppColors.textLo)),
          ),
        ),
      ],
    );
  }

  Widget _buildDone() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('⏱️', style: TextStyle(fontSize: 60)),
            const SizedBox(height: 12),
            const Text('Konec kola!',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textHi)),
            const SizedBox(height: 20),
            Text('$_correct',
                style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w900,
                    color: AppColors.leaf)),
            const Text('uhodnutých slov',
                style: TextStyle(color: AppColors.textLo, fontSize: 16)),
            const SizedBox(height: 8),
            Text('Přeskočeno: $_skipped',
                style: const TextStyle(color: AppColors.textLo)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => setState(() => _phase = _Phase.setup),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.leaf,
                foregroundColor: AppColors.night,
              ),
              icon: const Icon(Icons.replay),
              label: const Text('Nové kolo'),
            ),
          ],
        ),
      ),
    );
  }
}
