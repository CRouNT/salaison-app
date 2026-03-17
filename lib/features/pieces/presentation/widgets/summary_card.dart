import 'package:flutter/material.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/core/theme/app_theme.dart';
import 'package:salaison_app/core/utils/calculations.dart';
import 'package:salaison_app/core/utils/unit_converter.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/ingredients_table.dart';

/// Carte de résumé des caractéristiques d'une pièce.
/// Regroupe le poids cible, le fumage et le tableau des ingrédients.
class SummaryCard extends StatelessWidget {
  final Piece piece;
  final List<Spice> spices;
  final UnitSystem system;

  const SummaryCard({
    super.key,
    required this.piece,
    required this.spices,
    required this.system,
  });

  @override
  Widget build(BuildContext context) {
    final baseWeight = piece.preDryingWeight ?? piece.poidsInitial;
    final targetLossRatio = 1 - (piece.poidsCible / piece.poidsInitial);
    final currentTarget = SalaisonCalculations.calculateTargetWeight(baseWeight, lossPercentage: targetLossRatio);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryRow(label: 'Poids de départ', value: UnitConverter.formatWeight(piece.poidsInitial, system)),
            _SummaryRow(label: 'Objectif de poids', value: UnitConverter.formatWeight(currentTarget, system)),
            const SizedBox(height: 16),
            if (piece.woodBlend != null && piece.woodBlend!.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.boisBrun.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.fireplace, color: AppTheme.boisBrun, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Fumage : ${piece.woodBlend}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.boisBrun),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (piece.smokingDuration > 0) ...[
              _SummaryRow(label: 'Temps de fumage', value: '${piece.smokingDuration.toStringAsFixed(1)}h'),
              const SizedBox(height: 16),
            ],
            ExpansionTile(
              title: const Text('Ingrédients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text('${spices.length + 2} éléments'),
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.only(top: 8, bottom: 16),
              shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
              collapsedShape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
              children: [
                IngredientsTable(
                  key: ValueKey('${piece.id}_${spices.length}'),
                  piece: piece, 
                  spices: spices, 
                  system: system
                ),
              ],
            ),
            if (piece.preDryingWeight != null) ...[
               const Divider(height: 32),
               const Center(
                 child: Text('Cible basée sur le poids avant séchage', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.orange, fontSize: 12)),
               ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.bold))],
      ),
    );
  }
}
