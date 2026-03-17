import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/core/theme/app_theme.dart';
import 'package:drift/drift.dart' as drift;

class TourDeCaveScreen extends ConsumerStatefulWidget {
  const TourDeCaveScreen({super.key});

  @override
  ConsumerState<TourDeCaveScreen> createState() => _TourDeCaveScreenState();
}

class _TourDeCaveScreenState extends ConsumerState<TourDeCaveScreen> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _saveAll(List<Piece> pieces) async {
    if (!_formKey.currentState!.validate()) return;
    final repository = ref.read(piecesRepositoryProvider);
    final companions = <WeighingsCompanion>[];

    for (var piece in pieces) {
      final text = _controllers[piece.id]?.text;
      if (text != null && text.isNotEmpty) {
        final weight = double.tryParse(text);
        if (weight != null) {
          companions.add(WeighingsCompanion.insert(
            pieceId: piece.id,
            date: DateTime.now(),
            poids: weight,
            label: const drift.Value('Séchage (Tour de Cave)'),
          ));
        }
      }
    }

    if (companions.isEmpty) return;

    try {
      await repository.addWeighings(companions);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Toutes les pesées ont été enregistrées !')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'enregistrement : $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final piecesStream = ref.watch(piecesRepositoryProvider).watchAllPieces();

    return Scaffold(
      appBar: AppBar(title: const Text('Tour de Cave')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: StreamBuilder<List<Piece>>(
            stream: piecesStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

              final dryingPieces = snapshot.data!.where((p) => p.statut == 'Séchage' && !p.isArchived).toList();

              if (dryingPieces.isEmpty) {
                return const Center(child: Text('Aucune pièce en séchage.'));
              }

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: dryingPieces.length,
                      itemBuilder: (context, index) {
                        final piece = dryingPieces[index];
                        final controller = _controllers.putIfAbsent(piece.id, () => TextEditingController());

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppTheme.bordure),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(piece.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text(
                                        'ID: ${piece.physicalID ?? 'N/A'}',
                                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                      labelText: 'Poids (g)',
                                      suffixText: 'g',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    validator: (value) {
                                      if (value != null && value.isNotEmpty) {
                                        final weight = double.tryParse(value);
                                        if (weight == null || weight <= 0) return 'Invalide';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _saveAll(dryingPieces),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.vertForet,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('ENREGISTRER TOUTES LES PESÉES', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            );
            },
          ),
        ),
      ),
    );
  }
}
