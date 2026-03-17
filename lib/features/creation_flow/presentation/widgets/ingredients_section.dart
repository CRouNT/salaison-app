import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/utils/unit_converter.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';

class SpiceController {
  final TextEditingController name;
  final TextEditingController weight;
  SpiceController({required String n, required String w})
      : name = TextEditingController(text: n),
        weight = TextEditingController(text: w);

  void dispose() {
    name.dispose();
    weight.dispose();
  }
}

class IngredientsSection extends ConsumerWidget {
  final TextEditingController saltPercentController;
  final TextEditingController saltWeightController;
  final TextEditingController sugarPercentController;
  final TextEditingController sugarWeightController;
  final FocusNode saltWeightFocus;
  final FocusNode saltPercentFocus;
  final FocusNode sugarWeightFocus;
  final FocusNode sugarPercentFocus;
  final List<SpiceController> spiceControllers;
  final VoidCallback onAddSpice;
  final ValueChanged<SpiceController> onRemoveSpice;
  final ValueChanged<String> onSaltPercentChanged;
  final ValueChanged<String> onSaltWeightChanged;
  final ValueChanged<String> onSugarPercentChanged;
  final ValueChanged<String> onSugarWeightChanged;

  const IngredientsSection({
    super.key,
    required this.saltPercentController,
    required this.saltWeightController,
    required this.sugarPercentController,
    required this.sugarWeightController,
    required this.saltWeightFocus,
    required this.saltPercentFocus,
    required this.sugarWeightFocus,
    required this.sugarPercentFocus,
    required this.spiceControllers,
    required this.onAddSpice,
    required this.onRemoveSpice,
    required this.onSaltPercentChanged,
    required this.onSaltWeightChanged,
    required this.onSugarPercentChanged,
    required this.onSugarWeightChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final system = ref.watch(unitSystemProvider);
    final unitSuffix = UnitConverter.getSuffix(500, system);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.ingredients, style: Theme.of(context).textTheme.titleMedium),
            TextButton.icon(
              onPressed: () {
                // Reset to standard
                saltPercentController.text = '4.0';
                sugarPercentController.text = '2.0';
              },
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(l10n.resetStandard, style: const TextStyle(fontSize: 12)),
              style: TextButton.styleFrom(foregroundColor: Colors.blueGrey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        // Salt Row
        Row(
          children: [
            Expanded(flex: 2, child: Text(l10n.salt, style: const TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: saltPercentController,
                focusNode: saltPercentFocus,
                decoration: const InputDecoration(labelText: '%', suffixText: '%', border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: onSaltPercentChanged,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: saltWeightController,
                focusNode: saltWeightFocus,
                decoration: InputDecoration(
                  labelText: l10n.weight, 
                  suffixText: unitSuffix, 
                  border: const OutlineInputBorder()
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: onSaltWeightChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Sugar Row
        Row(
          children: [
            Expanded(flex: 2, child: Text(l10n.sugar, style: const TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: sugarPercentController,
                focusNode: sugarPercentFocus,
                decoration: const InputDecoration(labelText: '%', suffixText: '%', border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: onSugarPercentChanged,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: sugarWeightController,
                focusNode: sugarWeightFocus,
                decoration: InputDecoration(
                  labelText: l10n.weight, 
                  suffixText: unitSuffix, 
                  border: const OutlineInputBorder()
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: onSugarWeightChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Spices
        ...spiceControllers.map((s) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Expanded(flex: 2, child: TextFormField(controller: s.name, decoration: InputDecoration(labelText: l10n.spices, border: const OutlineInputBorder()))),
              const SizedBox(width: 8),
              Expanded(child: TextFormField(controller: s.weight, decoration: InputDecoration(labelText: l10n.weight, suffixText: unitSuffix, border: const OutlineInputBorder()), keyboardType: const TextInputType.numberWithOptions(decimal: true))),
              IconButton(icon: const Icon(Icons.delete_outline, color: Colors.grey), onPressed: () => onRemoveSpice(s)),
            ],
          ),
        )),
        
        OutlinedButton.icon(
          onPressed: onAddSpice,
          icon: const Icon(Icons.add),
          label: Text(l10n.addSpice),
        ),
      ],
    );
  }
}