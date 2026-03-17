import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/utils/unit_converter.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';
import 'package:salaison_app/features/pieces/data/taxonomy_repository.dart';
import 'package:salaison_app/core/database/app_database.dart';

class BasicInfoForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController physicalIdController;
  final TextEditingController initialWeightController;
  final TextEditingController targetWeightController;
  final TextEditingController targetLossController;
  final TextEditingController minSalaisonDaysController;
  final FocusNode targetWeightFocus;
  final FocusNode targetLossFocus;
  final int? selectedProductTypeId;
  final ValueChanged<int?> onProductTypeSelected;
  final ValueChanged<String> onInitialWeightChanged;
  final ValueChanged<String> onTargetLossChanged;
  final ValueChanged<String> onTargetWeightChanged;

  const BasicInfoForm({
    super.key,
    required this.formKey,
    required this.physicalIdController,
    required this.initialWeightController,
    required this.targetWeightController,
    required this.targetLossController,
    required this.minSalaisonDaysController,
    required this.targetWeightFocus,
    required this.targetLossFocus,
    required this.selectedProductTypeId,
    required this.onProductTypeSelected,
    required this.onInitialWeightChanged,
    required this.onTargetLossChanged,
    required this.onTargetWeightChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final system = ref.watch(unitSystemProvider);
    final unitSuffix = UnitConverter.getSuffix(500, system);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product Type
          StreamBuilder<List<ProductType>>(
            stream: ref.watch(taxonomyRepositoryProvider).watchAllProductTypes(),
            builder: (context, snapshot) {
              final types = snapshot.data ?? [];
              return Autocomplete<ProductType>(
                displayStringForOption: (option) => option.label,
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') return types;
                  return types.where((t) => t.label.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (selection) => onProductTypeSelected(selection.id),
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    onFieldSubmitted: (v) => onFieldSubmitted(),
                    decoration: InputDecoration(
                      labelText: l10n.productType, 
                      border: const OutlineInputBorder(), 
                      suffixIcon: const Icon(Icons.search)
                    ),
                    validator: (v) {
                      if (selectedProductTypeId == null) return l10n.error;
                      return null;
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 16),
          
          // Physical ID
          TextFormField(
            controller: physicalIdController,
            decoration: InputDecoration(
              labelText: l10n.physicalId, 
              hintText: 'ex: A1, B2', 
              border: const OutlineInputBorder()
            ),
            validator: (v) => v?.isEmpty ?? true ? l10n.error : null,
          ),
          const SizedBox(height: 16),
          
          // Initial Weight
          TextFormField(
            controller: initialWeightController,
            decoration: InputDecoration(
              labelText: '${l10n.initialWeight} ($unitSuffix)', 
              suffixText: unitSuffix, 
              border: const OutlineInputBorder()
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              final val = double.tryParse(v ?? '');
              if (val == null || val <= 0) return l10n.error;
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          // Target Weight and Loss
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: targetWeightController,
                  focusNode: targetWeightFocus,
                  decoration: InputDecoration(
                    labelText: '${l10n.targetWeight} ($unitSuffix)', 
                    suffixText: unitSuffix, 
                    border: const OutlineInputBorder()
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    final val = double.tryParse(v ?? '');
                    if (val == null || val <= 0) return l10n.error;
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: targetLossController,
                  focusNode: targetLossFocus,
                  decoration: InputDecoration(
                    labelText: l10n.targetLoss, 
                    suffixText: '%', 
                    border: const OutlineInputBorder()
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Min Salaison Days
          TextFormField(
            controller: minSalaisonDaysController,
            decoration: InputDecoration(
              labelText: '${l10n.minSalaisonDays} (${l10n.days})', 
              suffixText: l10n.days, 
              border: const OutlineInputBorder()
            ),
            keyboardType: TextInputType.number,
            validator: (v) => int.tryParse(v ?? '') == null ? l10n.error : null,
          ),
        ],
      ),
    );
  }
}