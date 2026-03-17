/// Dialogue de pesée critique pour le début du séchage.
/// 
/// Ce widget gère la pesée de référence cruciale avant d'entamer le séchage long.
/// Cette pesée servira de point de référence pour toutes les pesées ultérieures
/// pendant la phase de séchage.
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

/// Widget affichant la boîte de dialogue de pesée de pré-séchage.
class PreDryingDialog extends StatefulWidget {
  final Piece piece;
  final String nextStatus;
  final double? currentWeight;
  final VoidCallback onPreDryingSet;

  const PreDryingDialog({
    super.key,
    required this.piece,
    required this.nextStatus,
    required this.currentWeight,
    required this.onPreDryingSet,
  });

  @override
  State<PreDryingDialog> createState() => _PreDryingDialogState();
}

class _PreDryingDialogState extends State<PreDryingDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentWeight?.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final system = ref.watch(unitSystemProvider);

    return AlertDialog(
      title: const Text('Pesée de Séchage (CRITIQUE)'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'C\'est le poids de référence final pour le séchage.',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: '${l10n.weight} (${UnitConverter.getSuffix(widget.currentWeight ?? 500, system)})', 
              border: const OutlineInputBorder(),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => _setPreDryingWeight(context, ref),
          child: Text(l10n.validate),
        ),
      ],
    );
  }

  /// Enregistre la pesée de pré-séchage et met à jour le statut de la pièce.
  Future<void> _setPreDryingWeight(BuildContext context, WidgetRef ref) async {
    try {
      final weightInput = double.tryParse(_controller.text);
      if (weightInput != null) {
        final currentUnit3 = UnitConverter.getSuffix(weightInput, system);
        final storageWeight = UnitConverter.toGrams(weightInput, currentUnit3);

        if (widget.currentWeight != null && storageWeight > widget.currentWeight!) {
          final confirm = await _showIncreaseWarning(context);
          if (!confirm) return;
        }

        await ref.read(piecesRepositoryProvider).addWeighing(
          WeighingsCompanion.insert(
            pieceId: widget.piece.id,
            date: DateTime.now(),
            poids: storageWeight,
            label: const drift.Value('Séchage'),
          ),
        );

        await ref.read(piecesRepositoryProvider).updatePiece(
          widget.piece.toCompanion(false).copyWith(
            statut: drift.Value(widget.nextStatus),
            preDryingWeight: drift.Value(storageWeight),
          ),
        );
        Navigator.pop(context);
        widget.onPreDryingSet();
      }
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

/// Fonction utilitaire pour afficher le dialogue de pré-séchage.
Future<void> showPreDryingDialog(
  BuildContext context,
  WidgetRef ref,
  Piece piece,
  String nextStatus,
  double? currentWeight,
  VoidCallback onPreDryingSet,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PreDryingDialog(
      piece: piece,
      nextStatus: nextStatus,
      currentWeight: currentWeight,
      onPreDryingSet: onPreDryingSet,
    ),
  );
}