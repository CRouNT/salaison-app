/// Dialogue de pesée pour le changement d'étape de salaison.
/// 
/// Ce widget gère les dialogues de pesée lors des transitions entre les différentes
/// étapes de la salaison (Salaison -> SSV, SSV -> Fumage, etc.). Il permet
/// d'enregistrer le poids actuel et de passer à l'étape suivante.
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

/// Widget affichant la boîte de dialogue de pesée de transition.
class TransitionWeighingDialog extends StatefulWidget {
  final Piece piece;
  final String nextStatus;
  final String label;
  final double? currentWeight;
  final VoidCallback onWeighingAdded;

  const TransitionWeighingDialog({
    super.key,
    required this.piece,
    required this.nextStatus,
    required this.label,
    required this.currentWeight,
    required this.onWeighingAdded,
  });

  @override
  State<TransitionWeighingDialog> createState() => _TransitionWeighingDialogState();
}

class _TransitionWeighingDialogState extends State<TransitionWeighingDialog> {
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
      title: Text('${l10n.weighing} : ${widget.label}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Veuillez enregistrer le poids pour passer à l\'étape ${widget.nextStatus}.'),
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
          onPressed: () => _addWeighing(context, ref),
          child: Text(l10n.next),
        ),
      ],
    );
  }

  /// Ajoute la pesée et met à jour le statut de la pièce.
  Future<void> _addWeighing(BuildContext context, WidgetRef ref) async {
    try {
      final weightInput = double.tryParse(_controller.text);
      if (weightInput == null) return;

      final transUnit = UnitConverter.getSuffix(weightInput, system);
      final storageWeight = UnitConverter.toGrams(weightInput, transUnit);

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

      final companion = widget.piece.toCompanion(false).copyWith(statut: drift.Value(widget.nextStatus));
      if (widget.nextStatus == 'Séchage') {
        companion.copyWith(preDryingWeight: drift.Value(storageWeight));
      }
      
      await ref.read(piecesRepositoryProvider).updatePiece(companion);
      Navigator.pop(context);
      widget.onWeighingAdded();
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

/// Fonction utilitaire pour afficher le dialogue de pesée de transition.
Future<void> showTransitionWeighingDialog(
  BuildContext context,
  WidgetRef ref,
  Piece piece,
  String nextStatus,
  String label,
  double? currentWeight,
  VoidCallback onWeighingAdded,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => TransitionWeighingDialog(
      piece: piece,
      nextStatus: nextStatus,
      label: label,
      currentWeight: currentWeight,
      onWeighingAdded: onWeighingAdded,
    ),
  );
}