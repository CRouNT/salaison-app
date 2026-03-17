/// Dialogues de sécurité et de confirmation pour les transitions critiques.
/// 
/// Ce widget regroupe les dialogues de confirmation utilisés lors des transitions
/// critiques entre les étapes de la salaison, notamment pour la sécurité alimentaire
/// et le respect des durées minimales de chaque étape.
/// 
/// Auteur: Système de génération de code
/// Date: v1.0.4
/// Licence: MIT

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';

/// Widget affichant la boîte de dialogue de sécurité pour les transitions d'étape.
class SalaisonSafetyDialog extends StatelessWidget {
  final int minDays;
  final VoidCallback onConfirmed;

  const SalaisonSafetyDialog({
    super.key,
    required this.minDays,
    required this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.passToNextStepTitle),
      content: Text(l10n.passToNextStepContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
            onConfirmed();
          },
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}

/// Widget affichant la boîte de dialogue d'avertissement de poids en hausse.
class WeightIncreaseWarningDialog extends StatelessWidget {
  final VoidCallback onConfirmed;
  final VoidCallback onEdit;

  const WeightIncreaseWarningDialog({
    super.key,
    required this.onConfirmed,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: const Text('Poids en hausse ?'),
      content: const Text('Le poids semble avoir augmenté par rapport à la dernière pesée. Confirmer ?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
            onEdit();
          },
          child: Text(l10n.edit),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
            onConfirmed();
          },
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}

/// Fonction utilitaire pour afficher le dialogue de sécurité de transition.
Future<bool> showSalaisonSafetyCheck(
  BuildContext context,
  int minDays,
) async {
  final l10n = AppLocalizations.of(context)!;
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.passToNextStepTitle),
      content: Text(l10n.passToNextStepContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.confirm),
        ),
      ],
    ),
  ) ?? false;
}

/// Fonction utilitaire pour afficher l'avertissement de poids en hausse.
Future<bool> showWeightIncreaseWarning(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Poids en hausse ?'),
      content: const Text('Le poids semble avoir augmenté par rapport à la dernière pesée. Confirmer ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.edit),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.confirm),
        ),
      ],
    ),
  ) ?? false;
}