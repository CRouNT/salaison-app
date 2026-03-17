import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/piece_card.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';

/// Écran principal affichant la liste des salaisons actives.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final piecesStream = ref.watch(piecesRepositoryProvider).watchAllPieces();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            onPressed: () => context.push('/tour-de-cave'),
            icon: const Icon(Icons.scale),
            tooltip: l10n.tourDeCave,
          ),
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: StreamBuilder<List<Piece>>(
            stream: piecesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
    
              final allPieces = snapshot.data ?? [];
              final activePieces = allPieces.where((p) => !p.isArchived).toList();
    
              if (activePieces.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noActiveSalaison,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }
    
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: activePieces.length,
                itemBuilder: (context, index) {
                  return PieceCard(piece: activePieces[index]);
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
