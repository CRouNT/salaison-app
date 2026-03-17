/// Ancienne classe utilitaire regroupant les dialogues métier.
/// 
/// Cette classe est maintenue pour compatibilité ascendante mais est dépréciée.
/// Préférez utiliser les widgets individuels dans /dialogs/ pour une meilleure modularité.
/// 
/// Auteur: Système de génération de code
/// Date: v1.0.4
/// Licence: MIT

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:drift/drift.dart' as drift;
import 'package:salaison_app/core/utils/unit_converter.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';

// Import des nouveaux widgets de dialogues
import 'dialogs/delete_piece_dialog.dart';
import 'dialogs/transition_weighing_dialog.dart';
import 'dialogs/smoking_dialog.dart';
import 'dialogs/pre_drying_dialog.dart';
import 'dialogs/add_weighing_dialog.dart';
import 'dialogs/final_weighing_dialog.dart';
import 'dialogs/safety_dialogs.dart';

/// Classe utilitaire dépréciée contenant les boîtes de dialogue métier de l'application.
/// 
/// **ATTENTION** : Cette classe est maintenue pour compatibilité ascendante.
/// Pour de nouveaux développements, utilisez les widgets individuels dans `/dialogs/`.
@Deprecated('Use individual dialog widgets in /dialogs/ instead')
class PieceDialogs {
  /// Demande confirmation avant la suppression définitive d'une pièce.
  /// @deprecated Use DeletePieceDialog or showDeletePieceDialog instead
  @Deprecated('Use DeletePieceDialog or showDeletePieceDialog instead')
  static void confirmDelete(BuildContext context, WidgetRef ref, Piece piece) {
    showDeletePieceDialog(
      context,
      ref,
      piece,
      () => {}, // Callback vide pour compatibilité
    );
  }

  /// Affiche le dialogue pour enregistrer une session de fumage.
  /// @deprecated Use SmokingDialog or showSmokingDialog instead
  @Deprecated('Use SmokingDialog or showSmokingDialog instead')
  static void promptForSmoking(BuildContext context, WidgetRef ref, Piece piece, double? currentWeight) {
    showSmokingDialog(
      context,
      ref,
      piece,
      currentWeight,
      () => {}, // Callback vide pour compatibilité
    );
  }

  /// Affiche le dialogue de pesée lors du changement d'étape.
  /// @deprecated Use TransitionWeighingDialog or showTransitionWeighingDialog instead
  @Deprecated('Use TransitionWeighingDialog or showTransitionWeighingDialog instead')
  static void promptForTransitionWeighing(BuildContext context, WidgetRef ref, Piece piece, String nextStatus, String label, double? currentWeight) {
    showTransitionWeighingDialog(
      context,
      ref,
      piece,
      nextStatus,
      label,
      currentWeight,
      () => {}, // Callback vide pour compatibilité
    );
  }

  /// Pesée critique de référence avant d'entamer le séchage long.
  /// @deprecated Use PreDryingDialog or showPreDryingDialog instead
  @Deprecated('Use PreDryingDialog or showPreDryingDialog instead')
  static void promptForPreDryingWeight(BuildContext context, WidgetRef ref, Piece piece, String nextStatus, double? currentWeight) {
    showPreDryingDialog(
      context,
      ref,
      piece,
      nextStatus,
      currentWeight,
      () => {}, // Callback vide pour compatibilité
    );
  }

  /// Ajoute une pesée manuelle simple pendant la phase de séchage.
  /// @deprecated Use AddWeighingDialog or showAddWeighingDialog instead
  @Deprecated('Use AddWeighingDialog or showAddWeighingDialog instead')
  static void showAddWeighingDialog(BuildContext context, WidgetRef ref, int pieceId, double? lastWeight) {
    showAddWeighingDialog(
      context,
      ref,
      pieceId,
      lastWeight,
      () => {}, // Callback vide pour compatibilité
    );
  }

  /// Dernière pesée avant archivage, avec calcul de performance finale.
  /// @deprecated Use FinalWeighingDialog or showFinalWeighingDialog instead
  @Deprecated('Use FinalWeighingDialog or showFinalWeighingDialog instead')
  static void promptForFinalWeighing(BuildContext context, WidgetRef ref, Piece piece, double? currentWeight) {
    showFinalWeighingDialog(
      context,
      ref,
      piece,
      currentWeight,
      () => {}, // Callback vide pour compatibilité
    );
  }

  /// Affiche le dialogue de sécurité pour les transitions d'étape.
  /// @deprecated Use SalaisonSafetyDialog or showSalaisonSafetyCheck instead
  @Deprecated('Use SalaisonSafetyDialog or showSalaisonSafetyCheck instead')
  static Future<bool> showSalaisonSafetyCheck(BuildContext context, int minDays) async {
    return await showSalaisonSafetyCheck(context, minDays);
  }

  /// Avertit l'utilisateur si le poids saisi est supérieur au poids précédent.
  /// @deprecated Use WeightIncreaseWarningDialog or showWeightIncreaseWarning instead
  @Deprecated('Use WeightIncreaseWarningDialog or showWeightIncreaseWarning instead')
  static Future<bool> _showIncreaseWarning(BuildContext context) async {
    return await showWeightIncreaseWarning(context);
  }
}
