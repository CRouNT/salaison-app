import 'package:flutter/material.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/core/theme/app_theme.dart';
import 'package:salaison_app/core/utils/unit_converter.dart';

/// Tableau d'affichage des ingrédients (Sel, Sucre, Épices).
/// Utilise le facteur de poids (kg/g) pour l'affichage.
class IngredientsTable extends StatelessWidget {
  final Piece piece;
  final List<Spice> spices;
  final UnitSystem system;

  const IngredientsTable({
    super.key,
    required this.piece,
    required this.spices,
    required this.system,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.bordure),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(AppTheme.boisBrun.withOpacity(0.05)),
          horizontalMargin: 16,
          columnSpacing: 24,
          columns: const [
            DataColumn(label: Text('Ingrédient', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Quantité', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(Text('Sel')),
              DataCell(Text(UnitConverter.formatWeight(piece.quantiteSel, system))),
            ]),
            DataRow(cells: [
              const DataCell(Text('Sucre')),
              DataCell(Text(UnitConverter.formatWeight(piece.quantiteSucre, system))),
            ]),
            ...spices.map((s) => DataRow(cells: [
              DataCell(Text(s.nom)),
              DataCell(Text(UnitConverter.formatWeight(s.quantite, system))),
            ])),
          ],
        ),
      ),
    );
  }
}
