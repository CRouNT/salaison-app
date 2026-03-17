import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/features/pieces/presentation/widgets/spice_controllers.dart';
import 'package:drift/drift.dart' as drift;

/// Contenu du dialogue d'édition d'une pièce existante.
/// Permet de modifier le nom, les poids et la liste des épices secondaires.
class EditPieceDialogContent extends ConsumerStatefulWidget {
  final Piece piece;
  final List<Spice> initialSpices;
  final TextEditingController nameController;
  final TextEditingController initialWeightController;
  final TextEditingController targetWeightController;

  const EditPieceDialogContent({
    super.key,
    required this.piece,
    required this.initialSpices,
    required this.nameController,
    required this.initialWeightController,
    required this.targetWeightController,
  });

  @override
  ConsumerState<EditPieceDialogContent> createState() => _EditPieceDialogContentState();
}

class _EditPieceDialogContentState extends ConsumerState<EditPieceDialogContent> {
  final List<SpiceControllers> _spiceControllers = [];

  @override
  void initState() {
    super.initState();
    for (var spice in widget.initialSpices) {
      final sc = SpiceControllers();
      sc.name.text = spice.nom;
      sc.weight.text = spice.quantite.toStringAsFixed(2);
      _spiceControllers.add(sc);
    }
  }

  @override
  void dispose() {
    for (var sc in _spiceControllers) {
      sc.dispose();
    }
    super.dispose();
  }

  void _addSpice() {
    setState(() {
      _spiceControllers.add(SpiceControllers());
    });
  }

  void _removeSpice(int index) {
    setState(() {
      _spiceControllers[index].dispose();
      _spiceControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(piecesRepositoryProvider);

    return StreamBuilder<List<Weighing>>(
      stream: repo.watchWeighingsForPiece(widget.piece.id),
      builder: (context, snapshot) {
        final hasWeighings = snapshot.hasData && snapshot.data!.isNotEmpty;

        return AlertDialog(
          title: const Text('Modifier la pièce'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: widget.nameController,
                  decoration: const InputDecoration(labelText: 'Nom', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: widget.initialWeightController,
                  decoration: InputDecoration(
                    labelText: 'Poids initial (g)',
                    suffixText: 'g',
                    border: const OutlineInputBorder(),
                    helperText: hasWeighings ? 'Attention: Des pesées existent déjà' : null,
                    helperStyle: hasWeighings ? const TextStyle(color: Colors.orange) : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: widget.targetWeightController,
                  decoration: const InputDecoration(labelText: 'Poids cible (g)', suffixText: 'g', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                const Divider(),
                Text('Épices', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                ..._spiceControllers.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(child: TextField(controller: entry.value.name, decoration: const InputDecoration(labelText: 'Nom', border: OutlineInputBorder()))),
                        const SizedBox(width: 8),
                        Expanded(child: TextField(controller: entry.value.weight, decoration: const InputDecoration(labelText: 'Grs', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                        IconButton(onPressed: () => _removeSpice(entry.key), icon: const Icon(Icons.close)),
                      ],
                    ),
                  );
                }),
                TextButton.icon(onPressed: _addSpice, icon: const Icon(Icons.add), label: const Text('Ajouter une épice')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
            ElevatedButton(
              onPressed: () async {
                try {
                  final newInitial = double.tryParse(widget.initialWeightController.text);
                  final newTarget = double.tryParse(widget.targetWeightController.text);
                  if (newTarget != null && newInitial != null && widget.nameController.text.isNotEmpty) {
                    // Mise à jour de la pièce principale
                    await repo.updatePiece(
                      widget.piece.toCompanion(false).copyWith(
                        nom: drift.Value(widget.nameController.text),
                        poidsInitial: drift.Value(newInitial),
                        poidsCible: drift.Value(newTarget),
                      ),
                    );

                    // Mise à jour synchronisée des épices secondaires (on ignore Sel/Sucre)
                    final spicesToSave = _spiceControllers
                        .where((sc) => sc.name.text.isNotEmpty && sc.name.text != 'Sel' && sc.name.text != 'Sucre')
                        .map((sc) => SpicesCompanion.insert(
                              pieceId: widget.piece.id,
                              nom: sc.name.text,
                              quantite: double.tryParse(sc.weight.text) ?? 0.0,
                            ))
                        .toList();
                    await repo.updateSpices(widget.piece.id, spicesToSave);

                    if (context.mounted) Navigator.pop(context);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
                    );
                  }
                }
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }
}
