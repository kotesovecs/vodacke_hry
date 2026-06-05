import 'dart:math';

import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme.dart';
import '../widgets/party_banner.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<QuizQuestion> _questions;
  int _index = 0;
  int _score = 0;
  int? _picked;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _restart();
  }

  void _restart() {
    _questions = List<QuizQuestion>.from(quiz)..shuffle(Random());
    _index = 0;
    _score = 0;
    _picked = null;
    _finished = false;
  }

  void _pick(int i) {
    if (_picked != null) return;
    setState(() {
      _picked = i;
      if (i == _questions[_index].correctIndex) _score++;
    });
  }

  void _next() {
    setState(() {
      if (_index < _questions.length - 1) {
        _index++;
        _picked = null;
      } else {
        _finished = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vodácký kvíz')),
      extendBodyBehindAppBar: true,
      body: FireBackground(
        glow: AppColors.ember,
        child: SafeArea(
          child: _finished ? _buildResult() : _buildQuestion(),
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    final q = _questions[_index];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Otázka ${_index + 1} / ${_questions.length}',
                      style: const TextStyle(color: AppColors.textLo)),
                  Text('Skóre: $_score',
                      style: const TextStyle(
                          color: AppColors.gold, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (_index + 1) / _questions.length,
                  minHeight: 6,
                  backgroundColor: AppColors.nightCard,
                  color: AppColors.ember,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  q.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    height: 1.3,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textHi,
                  ),
                ),
                const SizedBox(height: 28),
                ...List.generate(q.options.length, (i) => _option(q, i)),
              ],
            ),
          ),
        ),
        if (_picked != null)
          PartyBanner(
            text: _picked == _questions[_index].correctIndex
                ? 'Správně! Rozdej jeden lok, komu chceš.'
                : 'Špatně! Dej si lok 🍺',
          ),
        if (_picked != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _next,
                child: Text(_index < _questions.length - 1
                    ? 'Další'
                    : 'Vyhodnotit'),
              ),
            ),
          ),
      ],
    );
  }

  Widget _option(QuizQuestion q, int i) {
    final isCorrect = i == q.correctIndex;
    Color border = AppColors.nightCard;
    Color bg = AppColors.nightCard;
    IconData? trailing;
    if (_picked != null) {
      if (isCorrect) {
        border = AppColors.leaf;
        bg = AppColors.leaf.withValues(alpha: 0.16);
        trailing = Icons.check_circle;
      } else if (i == _picked) {
        border = AppColors.rose;
        bg = AppColors.rose.withValues(alpha: 0.16);
        trailing = Icons.cancel;
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _pick(i),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: border, width: 1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    q.options[i],
                    style: const TextStyle(
                        fontSize: 16.5,
                        color: AppColors.textHi,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                if (trailing != null)
                  Icon(trailing,
                      color: isCorrect ? AppColors.leaf : AppColors.rose),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResult() {
    final total = _questions.length;
    final pct = _score / total;
    String verdict;
    String emoji;
    if (pct >= 0.85) {
      verdict = 'Vodácký bard! Znáš řeku jako svoje boty.';
      emoji = '🏆';
    } else if (pct >= 0.5) {
      verdict = 'Slušný háček. Ještě pár výletů a jsi za vodou.';
      emoji = '🚣';
    } else {
      verdict = 'Bahňák! Radši zůstaň u ohně a pivka.';
      emoji = '🍺';
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(
              '$_score / $total',
              style: const TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                  color: AppColors.gold),
            ),
            const SizedBox(height: 14),
            Text(
              verdict,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 19, height: 1.3, color: AppColors.textHi),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => setState(_restart),
              icon: const Icon(Icons.replay),
              label: const Text('Hrát znovu'),
            ),
          ],
        ),
      ),
    );
  }
}
