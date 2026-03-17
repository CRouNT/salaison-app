/// Dialogue de confirmation de suppression d'une pièce.
/// 
/// Ce widget affiche une boîte de dialogue demandant à l'utilisateur de confirmer
/// la suppression définitive d'une pièce de salaison. Cette action est irréversible.
/// 
/// Auteur: Système de génération de code
/// Date: v1.0.4
/// Licence: MIT

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';

/// Widget affichant la boîte de dialogue de confirmation de suppression.
class DeletePieceDialog extends StatelessWidget {
  final Piece piece;
  final VoidCallback onDeleted;

  const DeletePieceDialog({
    super.key,
    required this.piece,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.deletePieceTitle),
      content: Text(
        l10n.deletePieceContent(piece.nom),
        style: const TextStyle(color: Colors.red),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () => _confirmDelete(context, ref),
          child: Text(l10n.delete),
        ),
      ],
    );
  }

  /// Confirme la suppression de la pièce et ferme les écrans appropriés.
  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(piecesRepositoryProvider).deletePiece(piece.id);
      Navigator.pop(context); // ferme le dialogue
      Navigator.pop(context); // retour à l'accueil
      onDeleted();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.error}: $e')),
        );
      }
    }
  }
}

/// Fonction utilitaire pour afficher le dialogue de suppression.
/// 
/// Cette fonction peut être appelée directement pour afficher le dialogue
/// sans avoir à instancier le widget.
Future<void> showDeletePieceDialog(
  BuildContext context,
  WidgetRef ref,
  Piece piece,
  VoidCallback onDeleted,
) {
  return showDialog(
    context: context,
    builder: (context) => DeletePieceDialog(
      piece: piece,
      onDeleted: onDeleted,
    ),
  );
}