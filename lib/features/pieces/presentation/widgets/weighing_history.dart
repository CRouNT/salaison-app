import 'package:flutter/material.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/core/theme/app_theme.dart';
import 'package:salaison_app/core/utils/unit_converter.dart';

/// Liste chronologique (inversée) de l'historique des pesées.
/// Grise les pesées appartenant à des phases terminées.
class WeighingHistory extends StatelessWidget {
  final Piece piece;
  final List<Weighing> weighings;
  final UnitSystem system;

  const WeighingHistory({
    super.key,
    required this.piece,
    required this.weighings,
    required this.system,
  });

  @override
  Widget build(BuildContext context) {
    // Reverse logic: most recent on top
    // Final row (index == weightings.length) is the 'Point Zéro'
    final totalItems = weighings.length + 1;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalItems,
      itemBuilder: (context, index) {
        if (index == totalItems - 1) {
          // Point Zéro at the bottom
          final baseWeightText = piece.preDryingWeight != null
              ? '${UnitConverter.formatWeight(piece.preDryingWeight!, system)} (Pré-séchage)'
              : '${UnitConverter.formatWeight(piece.poidsInitial, system)} (Initial)';
          final baseDate = piece.dateDebut;

          return ListTile(
            leading: const Icon(Icons.flag_circle_outlined, color: Colors.grey),
            title: Text(baseWeightText, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            subtitle: Text('Point Zéro - ${baseDate.day}/${baseDate.month}/${baseDate.year}', style: const TextStyle(color: Colors.grey)),
          );
        }

        final w = weighings[index];
        final h = w.date.hour.toString().padLeft(2, '0');
        final m = w.date.minute.toString().padLeft(2, '0');
        final label = w.label ?? 'Séchage';
        
        // Greying logic: only colored if active phase (statut == label or label == 'Séchage' if statut is 'Séchage')
        final bool isSechageActive = piece.statut == 'Séchage' && (label == 'Séchage');
        // Actually the rule is: grey all past phase weighings.
        // If phase is 'Séchage', only 'Séchage' weighings are in color.
        final Color color = isSechageActive ? AppTheme.rougeBoeuf : Colors.grey;
        final FontWeight weightFont = isSechageActive ? FontWeight.bold : FontWeight.normal;

        return ListTile(
          leading: Icon(Icons.scale, color: color),
          title: Text(UnitConverter.formatWeight(w.poids, system), style: TextStyle(fontWeight: weightFont, color: color)),
          subtitle: Text('$label - ${w.date.day}/${w.date.month}/${w.date.year} $h:$m', style: TextStyle(color: color.withOpacity(0.7))),
        );
      },
    );
  }
}
