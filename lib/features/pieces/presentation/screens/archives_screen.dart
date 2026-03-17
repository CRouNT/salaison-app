import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/piece_card.dart';
import 'package:salaison_app/core/database/app_database.dart';

/// Écran affichant l'historique des pièces archivées.
class ArchivesScreen extends ConsumerWidget {
  const ArchivesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final piecesStream = ref.watch(piecesRepositoryProvider).watchAllPieces();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Archives'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Piece>>(
        stream: piecesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final allPieces = snapshot.data ?? [];
          final archivedPieces = allPieces.where((p) => p.isArchived).toList();

          if (archivedPieces.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.archive_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Aucune archive',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: archivedPieces.length,
            itemBuilder: (context, index) {
              return PieceCard(piece: archivedPieces[index]);
            },
          );
        },
      ),
    );
  }
}
