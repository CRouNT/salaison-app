/// Helper pour la gestion des transitions entre les étapes de salaison.
/// 
/// Ce service centralise la logique de transition entre les différentes étapes
/// du cycle de vie d'une pièce de salaison, en gérant les dialogues appropriés
/// selon l'étape actuelle.
/// 
/// Auteur: Système de génération de code
/// Date: v1.0.4
/// Licence: MIT

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/dialogs/safety_dialogs.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/dialogs/smoking_dialog.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/dialogs/pre_drying_dialog.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/dialogs/final_weighing_dialog.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/dialogs/transition_weighing_dialog.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';

/// Service de gestion des transitions entre les étapes de salaison.
class TransitionHelper {
  /// Gère la transition vers la phase suivante du cycle de vie de la pièce.
  /// Affiche les popups de sécurité ou de pesée selon l'étape actuelle.
  static Future<void> handleNextPhase(
    BuildContext context,
    WidgetRef ref,
    Piece piece,
    double currentWeight,
  ) async {
    try {
      if (piece.statut == 'Salaison (SSV)') {
        final confirm = await showSalaisonSafetyCheck(context, piece.minSalaisonDays);
        if (!confirm) return;
        if (context.mounted) {
          showTransitionWeighingDialog(
            context,
            ref,
            piece,
            'Repos (Grille)',
            'Sortie SSV',
            currentWeight,
            () => {}, // Callback vide pour compatibilité
          );
        }
      } else if (piece.statut == 'Repos (Grille)') {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.passToNextStepTitle),
            content: const Text('Voulez-vous fumer cette pièce ou passer directement au séchage ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showSmokingDialog(
                    context,
                    ref,
                    piece,
                    currentWeight,
                    () => {}, // Callback vide pour compatibilité
                  );
                },
                child: const Text('Fumage'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  showPreDryingDialog(
                    context,
                    ref,
                    piece,
                    'Séchage',
                    currentWeight,
                    () => {}, // Callback vide pour compatibilité
                  );
                },
                child: const Text('Séchage direct'),
              ),
            ],
          ),
        );
      } else if (piece.statut == 'Fumage') {
        showPreDryingDialog(
          context,
          ref,
          piece,
          'Séchage',
          currentWeight,
          () => {}, // Callback vide pour compatibilité
        );
      } else if (piece.statut == 'Séchage') {
        showFinalWeighingDialog(
          context,
          ref,
          piece,
          currentWeight,
          () => {}, // Callback vide pour compatibilité
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la transition : $e')),
        );
      }
    }
  }

  /// Vérifie si la pièce est prête pour la phase suivante.
  /// 
  /// Retourne true si le poids actuel est inférieur ou égal au poids cible.
  static bool isReadyForNextPhase(Piece piece, double currentWeight) {
    final baseWeight = piece.preDryingWeight ?? piece.poidsInitial;
    final targetLossRatio = 1 - (piece.poidsCible / piece.poidsInitial);
    final targetWeight = SalaisonCalculations.calculateTargetWeight(baseWeight, lossPercentage: targetLossRatio);
    
    return currentWeight <= targetWeight;
  }

  /// Obtient le texte de l'étape suivante.
  static String getNextPhaseText(Piece piece) {
    switch (piece.statut) {
      case 'Salaison (SSV)':
        return 'Repos (Grille)';
      case 'Repos (Grille)':
        return 'Fumage ou Séchage';
      case 'Fumage':
        return 'Séchage';
      case 'Séchage':
        return 'Terminé';
      default:
        return 'Inconnue';
    }
  }
}