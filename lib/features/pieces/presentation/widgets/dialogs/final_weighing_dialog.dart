/// Dialogue de pesée finale et clôture de la salaison.
/// 
/// Ce widget gère la dernière pesée avant l'archivage de la pièce. Il affiche
/// un résumé des performances de la salaison et demande confirmation
/// avant de passer la pièce en statut "Terminé".
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

/// Widget affichant la boîte de dialogue de pesée finale.
class FinalWeighingDialog extends StatefulWidget {
  final Piece piece;
  final double? currentWeight;
  final VoidCallback onFinalized;

  const FinalWeighingDialog({
    super.key,
    required this.piece,
    required this.currentWeight,
    required this.onFinalized,
  });

  @override
  State<FinalWeighingDialog> createState() => _FinalWeighingDialogState();
}

class _FinalWeighingDialogState extends State<FinalWeighingDialog> {
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
      title: const Text('Pesée Finale & Clôture'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Veuillez enregistrer le poids final avant d\'archiver la pièce.',
            style: TextStyle(fontWeight: FontWeight.bold),
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
          onPressed: () => _showFinalSummary(context, ref),
          child: Text(l10n.next),
        ),
      ],
    );
  }

  /// Affiche le résumé final avec les statistiques de performance.
  Future<void> _showFinalSummary(BuildContext context, WidgetRef ref) async {
    try {
      final weightInput = double.tryParse(_controller.text);
      if (weightInput == null) return;
      
      final currentUnit = UnitConverter.getSuffix(weightInput, system);
      final finalWeight = UnitConverter.toGrams(weightInput, currentUnit);

      // Calcul des statistiques finales
      final initialWeight = widget.piece.poidsInitial;
      final targetWeight = widget.piece.poidsCible;
      
      final realLossPct = (1 - (finalWeight / initialWeight)) * 100;
      final targetLossPct = (1 - (targetWeight / initialWeight)) * 100;

      Navigator.pop(context); // Ferme la saisie

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          bool isConfirmed = false;
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: const Text('Résumé de la Salaison'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Perte totale réelle : ${realLossPct.toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Objectif initial : ${targetLossPct.toStringAsFixed(1)}%',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      value: isConfirmed,
                      onChanged: (val) {
                        setDialogState(() => isConfirmed = val ?? false);
                      },
                      title: const Text(
                        'Je confirme que la pièce est prête à être consommée et archivée',
                        style: TextStyle(fontSize: 12),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: Text(l10n.cancel),
                  ),
                  ElevatedButton(
                    onPressed: isConfirmed ? () => _finalizePiece(context, ref, finalWeight) : null,
                    child: Text(l10n.validate),
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.error}: $e')),
        );
      }
    }
  }

  /// Finalise la pièce en enregistrant la pesée finale et en changeant le statut.
  Future<void> _finalizePiece(BuildContext context, WidgetRef ref, double finalWeight) async {
    try {
      // Enregistrement pesée finale
      await ref.read(piecesRepositoryProvider).addWeighing(
        WeighingsCompanion.insert(
          pieceId: widget.piece.id,
          date: DateTime.now(),
          poids: finalWeight,
          label: const drift.Value('Poids Final'),
        ),
      );

      // Passage au statut final
      await ref.read(piecesRepositoryProvider).updatePiece(
        widget.piece.toCompanion(false).copyWith(statut: const drift.Value('Terminé')),
      );
      
      Navigator.pop(context); // Close summary
      widget.onFinalized();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.error}: $e')),
        );
      }
    }
  }
}

/// Fonction utilitaire pour afficher le dialogue de pesée finale.
Future<void> showFinalWeighingDialog(
  BuildContext context,
  WidgetRef ref,
  Piece piece,
  double? currentWeight,
  VoidCallback onFinalized,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => FinalWeighingDialog(
      piece: piece,
      currentWeight: currentWeight,
      onFinalized: onFinalized,
    ),
  );
}