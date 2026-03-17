import 'package:flutter/material.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/core/theme/app_theme.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/utils/calculations.dart';
import 'package:salaison_app/core/utils/unit_converter.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';

/// Carte d'aperçu d'une pièce de salaison pour la liste principale.
/// Affiche le nom, le statut, le badge "PRÊT" et la barre de progression.
class PieceCard extends ConsumerWidget {
  /// Données de la pièce à afficher.
  final Piece piece;

  const PieceCard({
    super.key,
    required this.piece,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.watch(unitSystemProvider);
    
    return StreamBuilder<List<Weighing>>(
      stream: ref.watch(piecesRepositoryProvider).watchWeighingsForPiece(piece.id),
      builder: (context, snapshot) {
        final weighings = snapshot.data ?? [];
        final currentWeight = weighings.isNotEmpty ? weighings.first.poids : piece.poidsInitial;
        
        final bool isDrying = piece.statut == 'Séchage';
        final baseWeight = isDrying ? (piece.preDryingWeight ?? piece.poidsInitial) : piece.poidsInitial;
        final targetLossRatio = 1 - (piece.poidsCible / piece.poidsInitial);
        final currentTarget = SalaisonCalculations.calculateTargetWeight(baseWeight, lossPercentage: targetLossRatio);
        
        double progress = 0.0;
        if (baseWeight > currentTarget) {
          progress = ((baseWeight - currentWeight) / (baseWeight - currentTarget)).clamp(0.0, 1.0);
        }

        final bool isReady = currentWeight <= currentTarget && piece.statut != 'Terminé';

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () => context.push('/piece/${piece.id}'),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              piece.nom.split(' [').first,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppTheme.graphite,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                if (piece.physicalID != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppTheme.moutarde,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      piece.physicalID!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12,
                                        color: AppTheme.graphite,
                                      ),
                                    ),
                                  ),
                                _buildStatusChip(context, piece.statut),
                                if (isReady)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.green, width: 1),
                                    ),
                                    child: const Text(
                                      'PRÊT',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Départ: ${UnitConverter.formatWeight(piece.poidsInitial, system)}'),
                      Text('Cible: ${UnitConverter.formatWeight(currentTarget, system)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppTheme.bordure,
                    color: AppTheme.rougeBoeuf,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    Color chipColor;
    switch (status) {
      case 'Salaison (SSV)':
        chipColor = Colors.blue;
        break;
      case 'Repos (Grille)':
        chipColor = Colors.orange;
        break;
      case 'Fumage':
        chipColor = Colors.brown;
        break;
      case 'Séchage':
        chipColor = AppTheme.boisBrun;
        break;
      case 'Terminé':
        chipColor = AppTheme.vertForet;
        break;
      default:
        chipColor = AppTheme.rougeBoeuf;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        border: Border.all(color: chipColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: chipColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

}
