import 'package:flutter/material.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/core/theme/app_theme.dart';

/// Widget affichant la barre de progression par étapes (Stepper).
/// Indique visuellement l'avancement dans le cycle de vie de la salaison.
class ProcessStepper extends StatelessWidget {
  /// Données de la pièce pour calculer l'étape actuelle.
  final Piece piece;

  const ProcessStepper({super.key, required this.piece});

  @override
  Widget build(BuildContext context) {
    final phases = [
      'Balance',
      'Salaison (SSV)',
      'Repos (Grille)',
      'Fumage',
      'Séchage',
      'Terminé',
    ];

    final currentPhaseIndex = phases.indexOf(piece.statut);
    final bool hasFumage = piece.woodBlend != null || piece.smokingDuration > 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final showLabels = constraints.maxWidth > 400;

        return SizedBox(
          width: double.infinity,
          height: 100,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStep(context, 'Départ', Icons.balance, currentPhaseIndex >= 0, showLabels),
                _buildLine(currentPhaseIndex > 0),
                _buildStep(context, 'Salaison', Icons.app_registration, currentPhaseIndex >= 1, showLabels),
                _buildLine(currentPhaseIndex > 1),
                _buildStep(context, 'Repos', Icons.kitchen, currentPhaseIndex >= 2, showLabels),
                _buildLine(currentPhaseIndex > 2),
                if (hasFumage || piece.statut == 'Fumage') ...[
                  _buildStep(context, 'Fumage', Icons.cloud, currentPhaseIndex >= 3, showLabels),
                  _buildLine(currentPhaseIndex > 3),
                ],
                _buildStep(context, 'Séchage', Icons.house_siding, currentPhaseIndex >= 4, showLabels),
                _buildLine(currentPhaseIndex > 4),
                _buildStep(context, 'Terminé', Icons.verified, currentPhaseIndex >= 5, showLabels),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep(BuildContext context, String label, IconData icon, bool isActive, bool showLabel) {
    final color = isActive ? AppTheme.rougeBoeuf : Colors.grey.shade300;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 28),
        if (showLabel) ...[
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLine(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.rougeBoeuf : AppTheme.bordure,
      ),
    );
  }
}
