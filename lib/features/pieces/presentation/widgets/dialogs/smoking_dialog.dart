/// Dialogue de pesée et configuration pour le fumage.
/// 
/// Ce widget gère le dialogue de pesée lors de l'étape de fumage. Il permet
/// d'enregistrer le poids actuel, la durée de fumage et le mélange de bois utilisé.
/// 
/// Auteur: Système de génération de code
/// Date: v1.0.4
/// Licence: MIT

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/core/utils/unit_converter.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';

/// Widget affichant la boîte de dialogue de configuration de fumage.
class SmokingDialog extends StatefulWidget {
  final Piece piece;
  final double? currentWeight;
  final VoidCallback onSmokingConfigured;

  const SmokingDialog({
    super.key,
    required this.piece,
    required this.currentWeight,
    required this.onSmokingConfigured,
  });

  @override
  State<SmokingDialog> createState() => _SmokingDialogState();
}

class _SmokingDialogState extends State<SmokingDialog> {
  late final TextEditingController _weightController;
  late final TextEditingController _durationController;
  late final TextEditingController _woodBlendController;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(text: widget.currentWeight?.toStringAsFixed(1));
    _durationController = TextEditingController(text: '12');
    _woodBlendController = TextEditingController();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _durationController.dispose();
    _woodBlendController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final system = ref.watch(unitSystemProvider);

    return AlertDialog(
      title: Text(l10n.smokingTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.smokingContent, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: '${l10n.weight} (${UnitConverter.getSuffix(widget.currentWeight ?? 500, system)})', 
                border: const OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: '${l10n.smokingDuration} (${l10n.hours})', 
                border: const OutlineInputBorder(), 
                suffixText: l10n.hours,
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _woodBlendController,
              decoration: InputDecoration(
                labelText: '${l10n.woodBlend} (ex: 30% Oranger, 70% Hêtre)', 
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => _configureSmoking(context, ref),
          child: Text(l10n.validate),
        ),
      ],
    );
  }

  /// Configure le fumage en enregistrant la pesée et les paramètres.
  Future<void> _configureSmoking(BuildContext context, WidgetRef ref) async {
    try {
      final weightInput = double.tryParse(_weightController.text);
      final hours = double.tryParse(_durationController.text) ?? 0;
      if (weightInput == null) return;

      final smokingUnit = UnitConverter.getSuffix(weightInput, system);
      final storageWeight = UnitConverter.toGrams(weightInput, smokingUnit);

      if (widget.currentWeight != null && storageWeight > widget.currentWeight!) {
        final confirm = await _showIncreaseWarning(context);
        if (!confirm) return;
      }

      await ref.read(piecesRepositoryProvider).addWeighing(
        WeighingsCompanion.insert(
          pieceId: widget.piece.id,
          date: DateTime.now(),
          poids: storageWeight,
          label: const drift.Value('Sortie SSV'),
        ),
      );

      final newDuration = widget.piece.smokingDuration + hours;

      await ref.read(piecesRepositoryProvider).updatePiece(
        widget.piece.toCompanion(false).copyWith(
          statut: const drift.Value('Fumage'), 
          woodBlend: drift.Value(_woodBlendController.text),
          smokingDuration: drift.Value(newDuration),
        ),
      );
      Navigator.pop(context);
      widget.onSmokingConfigured();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.error}: $e')),
        );
      }
    }
  }

  /// Avertit l'utilisateur si le poids saisi est supérieur au poids précédent.
  Future<bool> _showIncreaseWarning(BuildContext context) async {
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
}

/// Fonction utilitaire pour afficher le dialogue de fumage.
Future<void> showSmokingDialog(
  BuildContext context,
  WidgetRef ref,
  Piece piece,
  double? currentWeight,
  VoidCallback onSmokingConfigured,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => SmokingDialog(
      piece: piece,
      currentWeight: currentWeight,
      onSmokingConfigured: onSmokingConfigured,
    ),
  );
}