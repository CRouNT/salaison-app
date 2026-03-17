import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/taxonomy_repository.dart';
import 'package:drift/drift.dart' as drift;

/// Écran de gestion de la taxonomie des produits.
/// Permet d'ajouter, modifier et supprimer les types de produits (Magret, Saucisson, etc.).
class TaxonomyScreen extends ConsumerWidget {
  const TaxonomyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typesStream = ref.watch(taxonomyRepositoryProvider).watchAllProductTypes();

    return Scaffold(
      appBar: AppBar(title: const Text('Types de Produits')),
      body: StreamBuilder<List<ProductType>>(
        stream: typesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final types = snapshot.data!;

          if (types.isEmpty) {
            return const Center(child: Text('Aucun type défini.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: types.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final type = types[index];
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.category_outlined),
                ),
                title: Text(type.label, style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                      onPressed: () => _showEditDialog(context, ref, type),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _handleDelete(context, ref, type),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context, ref),
        label: const Text('Nouveau Type'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un produit'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Libellé (ex: Coppa)',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await ref.read(taxonomyRepositoryProvider).addProductType(
                  ProductTypesCompanion.insert(label: controller.text.trim()),
                );
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, ProductType type) {
    final controller = TextEditingController(text: type.label);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Renommer le produit'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Nouveau libellé',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await ref.read(taxonomyRepositoryProvider).updateProductType(
                  type.toCompanion(true).copyWith(label: drift.Value(controller.text.trim())),
                );
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context, WidgetRef ref, ProductType type) async {
    try {
      await ref.read(taxonomyRepositoryProvider).deleteProductType(type.id);
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Suppression impossible'),
            content: Text(e.toString().replaceAll('Exception: ', '')),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
            ],
          ),
        );
      }
    }
  }
}
