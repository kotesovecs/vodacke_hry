import 'package:flutter/material.dart';

import '../models/game.dart';
import '../theme.dart';
import 'charades_screen.dart';
import 'heads_up_screen.dart';
import 'most_likely_screen.dart';
import 'quiz_screen.dart';
import 'truth_or_dare_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<GameInfo> get _games => [
        GameInfo(
          title: 'Kdo jsem?',
          tagline: 'Telefon na čelo, ostatní radí',
          icon: Icons.psychology_alt,
          color: AppColors.gold,
          builder: (_) => const HeadsUpScreen(),
        ),
        GameInfo(
          title: 'Kdo z nás nejspíš…',
          tagline: 'Ukaž prstem na viníka',
          icon: Icons.how_to_vote,
          color: AppColors.river,
          builder: (_) => const MostLikelyScreen(),
        ),
        GameInfo(
          title: 'Pravda nebo úkol',
          tagline: 'Klasika k ohni',
          icon: Icons.local_fire_department,
          color: AppColors.rose,
          builder: (_) => const TruthOrDareScreen(),
        ),
        GameInfo(
          title: 'Aktivity',
          tagline: 'Předváděj a popisuj na čas',
          icon: Icons.theater_comedy,
          color: AppColors.leaf,
          builder: (_) => const CharadesScreen(),
        ),
        GameInfo(
          title: 'Vodácký kvíz',
          tagline: 'Otestuj vodácké znalosti',
          icon: Icons.quiz,
          color: AppColors.ember,
          builder: (_) => const QuizScreen(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FireBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: _Header()),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                sliver: SliverList.separated(
                  itemCount: _games.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, i) => _GameCard(
                    info: _games[i],
                    index: i,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: _Footer()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 34)),
              const SizedBox(width: 10),
              Text(
                'Vodácké Hry',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.textHi,
                      letterSpacing: 0.5,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Společenské hry k ohni — stačí jeden telefon.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textLo,
                ),
          ),
        ],
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  const _GameCard({required this.info, required this.index});

  final GameInfo info;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.nightCard,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: info.builder),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: info.color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(info.icon, color: info.color, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textHi,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      info.tagline,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: AppColors.textLo,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: info.color.withValues(alpha: 0.8)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 28),
      child: Text(
        'Tip: posaďte se do kruhu, telefon kolujte. Ať to klape! 🚣',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.textLo, fontSize: 13),
      ),
    );
  }
}
