import 'package:flutter/material.dart';
import 'package:salaison_app/core/theme/app_theme.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';

class ActionsSection extends StatelessWidget {
  final VoidCallback onSavePiece;

  const ActionsSection({
    super.key,
    required this.onSavePiece,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: onSavePiece,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppTheme.rougeBoeuf,
            foregroundColor: Colors.white,
          ),
          child: Text(l10n.launchSalaison, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}