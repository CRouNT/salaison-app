import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/core/theme/app_theme.dart';
import 'package:salaison_app/core/utils/calculations.dart';
import 'package:salaison_app/features/pieces/presentation/screens/settings_screen.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/spice_controllers.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/process_stepper.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/weighing_history.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/edit_piece_dialog.dart';
import 'package:salaison_app/core/services/calendar_service.dart';
import 'package:salaison_app/core/services/pdf_service.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/summary_card.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/dialogs/delete_piece_dialog.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/dialogs/add_weighing_dialog.dart';
import 'package:salaison_app/features/pieces/presentation/helpers/transition_helper.dart';
import 'package:drift/drift.dart' as drift;
import 'package:salaison_app/core/utils/unit_converter.dart';

/// Écran de détail d'une pièce de salaison.
/// Affiche la progression, l'historique des pesées et permet de passer aux étapes suivantes.
class PieceDetailScreen extends ConsumerWidget {
  /// ID de la pièce à afficher.
  final int pieceId;

  const PieceDetailScreen({super.key, required this.pieceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(piecesRepositoryProvider);
    final system = ref.watch(unitSystemProvider);

    return StreamBuilder<Piece>(
      stream: repo.watchPiece(pieceId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Détails de la Salaison')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        final piece = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Détails de la Salaison'),
            actions: [
              if (piece.statut != 'Terminé')
                IconButton(
                  onPressed: () {
                    final nameController = TextEditingController(text: piece.nom);
                    final initialWeightController = TextEditingController(text: piece.poidsInitial.toStringAsFixed(2));
                    final targetWeightController = TextEditingController(text: piece.poidsCible.toStringAsFixed(2));
                    showDialog(
                      context: context,
                      builder: (context) => StreamBuilder<List<Spice>>(
                        stream: ref.read(piecesRepositoryProvider).watchSpicesForPiece(piece.id),
                        builder: (context, spicesSnapshot) => EditPieceDialogContent(
                          piece: piece,
                          initialSpices: spicesSnapshot.data ?? [],
                          nameController: nameController,
                          initialWeightController: initialWeightController,
                          targetWeightController: targetWeightController,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined),
                ),
                StreamBuilder<List<Weighing>>(
                stream: repo.watchWeighingsForPiece(pieceId),
                builder: (context, snapshot) {
                  final weighings = snapshot.data ?? [];
                  final currentWeight = weighings.isNotEmpty ? weighings.first.poids : piece.poidsInitial;
                  final baseWeight = piece.preDryingWeight ?? piece.poidsInitial;
                  final targetLossRatio = 1 - (piece.poidsCible / piece.poidsInitial);
                  final targetWeight = SalaisonCalculations.calculateTargetWeight(baseWeight, lossPercentage: targetLossRatio);

                  if (currentWeight <= targetWeight && piece.statut != 'Terminé') {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: const Text(
                          'PRÊT',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              if (piece.statut == 'Terminé' && !piece.isArchived)
                IconButton(
                  onPressed: () {
                    ref.read(piecesRepositoryProvider).updatePiece(
                      piece.toCompanion(false).copyWith(isArchived: const drift.Value(true)),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pièce archivée avec succès')));
                  },
                  icon: const Icon(Icons.archive_outlined),
                  tooltip: 'Archiver',
                ),
              IconButton(
                onPressed: () => showDeletePieceDialog(
                  context,
                  ref,
                  piece,
                  () => {}, // Callback vide pour compatibilité
                ),
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: StreamBuilder<List<Weighing>>(
                stream: repo.watchWeighingsForPiece(pieceId),
                builder: (context, weighingsSnapshot) {
                  final weighings = weighingsSnapshot.data ?? [];
                  final currentWeight = weighings.isNotEmpty ? weighings.first.poids : piece.poidsInitial;
                  // progress logic...
                  
                  return StreamBuilder<List<Spice>>(
                    stream: repo.watchSpicesForPiece(pieceId),
                    builder: (context, spicesSnapshot) {
                      final spices = spicesSnapshot.data ?? [];
                      
                      final baseWeight = piece.preDryingWeight ?? piece.poidsInitial;
                      final targetLossRatio = 1 - (piece.poidsCible / piece.poidsInitial);
                      final targetWeightCalc = SalaisonCalculations.calculateTargetWeight(baseWeight, lossPercentage: targetLossRatio);
    
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(context, ref, piece, currentWeight, system),
                            const SizedBox(height: 24),
                            SummaryCard(piece: piece, spices: spices, system: system),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Historique des pesées', style: Theme.of(context).textTheme.titleLarge),
                                  if (piece.statut == 'Séchage')
                                    ElevatedButton.icon(
                                      onPressed: () => showAddWeighingDialog(
                                        context,
                                        ref,
                                        pieceId,
                                        currentWeight,
                                        () => {}, // Callback vide pour compatibilité
                                      ),
                                      icon: const Icon(Icons.add_chart),
                                      label: const Text('Peser'),
                                    ),
                                if (piece.statut != 'Séchage' && piece.statut != 'Terminé')
                                  const Tooltip(
                                    message: 'Pesée obligatoire au changement d\'étape',
                                    child: Text('Verrouillé', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            WeighingHistory(piece: piece, weighings: weighings, system: system),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, Piece piece, double currentWeight, UnitSystem system) {
    // 1. Determine base weight for calculations (preDryingWeight if available, else initialWeight)
    final baseWeight = piece.preDryingWeight ?? piece.poidsInitial;
    
    // Calculate the target loss percentage from the original setup
    final targetLossRatio = 1 - (piece.poidsCible / piece.poidsInitial);
    
    // Recalculate targetWeight based on the CURRENT base weight
    final targetWeight = SalaisonCalculations.calculateTargetWeight(baseWeight, lossPercentage: targetLossRatio);
    
    final lossPct = SalaisonCalculations.calculateLossPercentage(baseWeight, currentWeight);

    // Simplified progress calculation
    double progress = 0;
    if (baseWeight > targetWeight) {
        progress = (baseWeight - currentWeight) / (baseWeight - targetWeight);
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          piece.nom, 
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.graphite, 
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ProcessStepper(piece: piece),
        const SizedBox(height: 16),
        if (piece.statut != 'Terminé') ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _handleNextPhase(context, ref, piece, currentWeight),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Suivant'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.rougeBoeuf.withOpacity(0.1),
                foregroundColor: AppTheme.rougeBoeuf,
                elevation: 0,
                minimumSize: const Size(double.infinity, 48), // Ensure touch target
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Poids actuel: ${UnitConverter.formatWeight(currentWeight, system)}', style: const TextStyle(fontSize: 18)),
            Text(
              '-${(lossPct * 100).toStringAsFixed(2)}%', 
              style: const TextStyle(fontSize: 18, color: AppTheme.vertForet, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          minHeight: 12,
          borderRadius: BorderRadius.circular(6),
          color: AppTheme.vertForet,
          backgroundColor: AppTheme.rougeBoeuf.withOpacity(0.1),
        ),
        const SizedBox(height: 4),
        Center(child: Text('Progression vers objectif: ${(progress * 100).clamp(0, 100).toStringAsFixed(1)}%')),
        const SizedBox(height: 24),
        Row(
          children: [
            if (piece.isArchived) ...[
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final spices = await ref.read(piecesRepositoryProvider).watchSpicesForPiece(piece.id).first;
                    final weighings = await ref.read(piecesRepositoryProvider).watchWeighingsForPiece(piece.id).first;
                    await PdfService().generatePieceReport(piece, spices, weighings);
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Exporter PDF'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.withOpacity(0.1),
                    foregroundColor: Colors.blueGrey,
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final date = DateTime.now().add(const Duration(days: 30)); // Estimate
                  final error = await CalendarService().addEvent(
                    title: '[Charcuterie] Sortie ${piece.statut} : ${piece.nom}',
                    eventDate: date,
                    description: 'Rappel automatique de l\'application Salaison.',
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error ?? 'Rappel ajouté !')),
                    );
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text('Agenda'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.boisBrun.withOpacity(0.1),
                  foregroundColor: AppTheme.boisBrun,
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (piece.preDryingWeight != null) ...[
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Cible basée sur le poids pré-séchage', 
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 12),
            ),
          ),
        ]
      ],
    );
  }

  /// Gère la transition vers la phase suivante du cycle de vie de la pièce.
  /// Affiche les popups de sécurité ou de pesée selon l'étape actuelle.
  void _handleNextPhase(BuildContext context, WidgetRef ref, Piece piece, double currentWeight) async {
    await TransitionHelper.handleNextPhase(context, ref, piece, currentWeight);
  }
}

