/// Dialogue d'ajout de pesée manuelle pendant la phase de séchage.
/// 
/// Ce widget permet d'ajouter une pesée manuelle simple pendant la phase de séchage.
/// Cette fonctionnalité est utile pour suivre l'évolution du poids tout au long
/// de la période de séchage.
/// 
/// Auteur: Système de génération de code
/// Date: v1.0.4
/// Licence: MIT

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/core/services/unit_converter.dart';
import 'package:salaison_app/core/providers/settings_provider.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';
import 'package:drift/drift.dart' as drift;

/// Widget affichant la boîte de dialogue d'ajout de pesée.
class AddWeighingDialog extends ConsumerWidget {
  final int pieceId;
  final double? lastWeight;
  final VoidCallback onWeighingAdded;

  const AddWeighingDialog({
    super.key,
    required this.pieceId,
    required this.lastWeight,
    required this.onWeighingAdded,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final system = ref.watch(unitSystemProvider);
    final controller = TextEditingController();

    return AlertDialog(
      title: Text(l10n.weighing),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: '${l10n.poidsActuel} (${UnitConverter.getSuffix(lastWeight ?? 500, system)})', 
          border: const OutlineInputBorder(),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => _addWeighing(context, ref, controller),
          child: Text(l10n.save),
        ),
      ],
    );
  }

  /// Ajoute la pesée manuelle à la base de données.
  Future<void> _addWeighing(BuildContext context, WidgetRef ref, TextEditingController controller) async {
    try {
      final weightInput = double.tryParse(controller.text);
      if (weightInput != null) {
        final currentUnit4 = UnitConverter.getSuffix(weightInput, ref.watch(unitSystemProvider));
        final storageWeight = UnitConverter.toGrams(weightInput, currentUnit4);

        if (lastWeight != null && storageWeight > lastWeight!) {
          final confirm = await _showIncreaseWarning(context);
          if (!confirm) return;
        }

        await ref.read(piecesRepositoryProvider).addWeighing(
          WeighingsCompanion.insert(
            pieceId: pieceId,
            date: DateTime.now(),
            poids: storageWeight,
            label: const drift.Value('Séchage'), // Uniquement manuel en phase Séchage
          ),
        );
        Navigator.pop(context);
        onWeighingAdded();
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

/// Fonction utilitaire pour afficher le dialogue d'ajout de pesée.
Future<void> showAddWeighingDialog(
  BuildContext context,
  WidgetRef ref,
  int pieceId,
  double? lastWeight,
  VoidCallback onWeighingAdded,
) {
  return showDialog(
    context: context,
    builder: (context) => AddWeighingDialog(
      pieceId: pieceId,
      lastWeight: lastWeight,
      onWeighingAdded: onWeighingAdded,
    ),
  );
}