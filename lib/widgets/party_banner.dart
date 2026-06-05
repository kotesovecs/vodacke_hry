import 'package:flutter/material.dart';

import '../state/party_mode.dart';
import '../theme.dart';

/// Malý pruh s pijáckým pravidlem, který se ukáže jen v párty režimu.
/// Reaguje na [partyMode], takže se sám schová/zobrazí podle přepínače.
class PartyBanner extends StatelessWidget {
  const PartyBanner({super.key, required this.text, this.margin});

  final String text;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: partyMode,
      builder: (context, on, _) {
        if (!on) return const SizedBox.shrink();
        return Container(
          width: double.infinity,
          margin: margin ?? const EdgeInsets.fromLTRB(20, 0, 20, 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.ember.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.ember.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              const Text('🍺', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.textHi,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
