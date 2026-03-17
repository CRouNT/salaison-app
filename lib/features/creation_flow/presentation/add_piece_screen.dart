import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/features/pieces/data/taxonomy_repository.dart';
import 'package:drift/drift.dart' as drift;
import 'package:salaison_app/core/utils/unit_converter.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';
import 'package:salaison_app/features/creation_flow/presentation/widgets/basic_info_form.dart';
import 'package:salaison_app/features/creation_flow/presentation/widgets/ingredients_section.dart';
import 'package:salaison_app/features/creation_flow/presentation/widgets/actions_section.dart';

class AddPieceScreen extends ConsumerStatefulWidget {
  const AddPieceScreen({super.key});

  @override
  ConsumerState<AddPieceScreen> createState() => _AddPieceScreenState();
}

class _AddPieceScreenState extends ConsumerState<AddPieceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _physicalIdController = TextEditingController();
  final _initialWeightController = TextEditingController();
  final _targetWeightController = TextEditingController();
  final _targetLossController = TextEditingController();
  final _minSalaisonDaysController = TextEditingController(text: '4');
  
  // Nouveaux contrôleurs pour Sel/Sucre
  final _saltPercentController = TextEditingController(text: '4.0');
  final _saltWeightController = TextEditingController();
  final _sugarPercentController = TextEditingController(text: '2.0');
  final _sugarWeightController = TextEditingController();

  final _targetWeightFocus = FocusNode();
  final _targetLossFocus = FocusNode();
  final _saltWeightFocus = FocusNode();
  final _saltPercentFocus = FocusNode();
  final _sugarWeightFocus = FocusNode();
  final _sugarPercentFocus = FocusNode();

  final List<SpiceController> _spiceControllers = [];
  int? _selectedProductTypeId;

  @override
  void initState() {
    super.initState();
    _initialWeightController.addListener(_updateAllCalculations);
    _targetLossController.addListener(_updateTargetWeightFromLoss);
    _targetWeightController.addListener(_updateLossFromTargetWeight);
    
    // Listeners pour Sel/Sucre
    _saltPercentController.addListener(_updateSaltWeightFromPercent);
    _saltWeightController.addListener(_updateSaltPercentFromWeight);
    _sugarPercentController.addListener(_updateSugarWeightFromPercent);
    _sugarWeightController.addListener(_updateSugarPercentFromWeight);

    _resetToStandard();
  }

  void _resetToStandard() {
    setState(() {
      for (var c in _spiceControllers) {
        c.dispose();
      }
      _spiceControllers.clear();
      _spiceControllers.add(SpiceController(n: 'Poivre', w: '0.0'));
      
      _saltPercentController.text = '4.0';
      _sugarPercentController.text = '2.0';
      _updateAllCalculations();
    });
  }

  void _updateAllCalculations() {
    _updateSaltWeightFromPercent();
    _updateSugarWeightFromPercent();
  }

  void _updateSaltWeightFromPercent() {
    if (_saltWeightFocus.hasFocus) return; // Priorité au poids manuel
    final initial = double.tryParse(_initialWeightController.text) ?? 0.0;
    final pct = double.tryParse(_saltPercentController.text) ?? 4.0;
    _saltWeightController.text = (initial * (pct / 100)).toStringAsFixed(1);
  }

  void _updateSaltPercentFromWeight() {
    if (!_saltWeightFocus.hasFocus) return; // Si pas focus, on ne change pas le %
    final initial = double.tryParse(_initialWeightController.text) ?? 0.0;
    final weight = double.tryParse(_saltWeightController.text) ?? 0.0;
    if (initial > 0) {
      _saltPercentController.text = ((weight / initial) * 100).toStringAsFixed(1);
    }
  }

  void _updateSugarWeightFromPercent() {
    if (_sugarWeightFocus.hasFocus) return;
    final initial = double.tryParse(_initialWeightController.text) ?? 0.0;
    final pct = double.tryParse(_sugarPercentController.text) ?? 2.0;
    _sugarWeightController.text = (initial * (pct / 100)).toStringAsFixed(1);
  }

  void _updateSugarPercentFromWeight() {
    if (!_sugarWeightFocus.hasFocus) return;
    final initial = double.tryParse(_initialWeightController.text) ?? 0.0;
    final weight = double.tryParse(_sugarWeightController.text) ?? 0.0;
    if (initial > 0) {
      _sugarPercentController.text = ((weight / initial) * 100).toStringAsFixed(1);
    }
  }

  void _updateTargetWeightFromLoss() {
    if (!_targetLossFocus.hasFocus) return;
    final weight = double.tryParse(_initialWeightController.text) ?? 0.0;
    final loss = double.tryParse(_targetLossController.text) ?? 35.0;
    final target = weight * (1 - (loss / 100));
    _targetWeightController.text = target.toStringAsFixed(1);
  }

  void _updateLossFromTargetWeight() {
    if (!_targetWeightFocus.hasFocus) return;
    final weight = double.tryParse(_initialWeightController.text) ?? 0.0;
    final target = double.tryParse(_targetWeightController.text) ?? 0.0;
    if (weight > 0) {
      final loss = (1 - (target / weight)) * 100;
      _targetLossController.text = loss.toStringAsFixed(1);
    }
  }

  @override
  void dispose() {
    _physicalIdController.dispose();
    _initialWeightController.dispose();
    _targetWeightController.dispose();
    _targetLossController.dispose();
    _minSalaisonDaysController.dispose();
    _saltPercentController.dispose();
    _saltWeightController.dispose();
    _sugarPercentController.dispose();
    _sugarWeightController.dispose();
    _targetWeightFocus.dispose();
    _targetLossFocus.dispose();
    _saltWeightFocus.dispose();
    _saltPercentFocus.dispose();
    _sugarWeightFocus.dispose();
    _sugarPercentFocus.dispose();
    for (var c in _spiceControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _savePiece() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final l10n = AppLocalizations.of(context)!;
      final system = ref.read(unitSystemProvider);
      final initialWeightRaw = double.tryParse(_initialWeightController.text) ?? 0.0;
      final targetWeightRaw = double.tryParse(_targetWeightController.text) ?? 0.0;
      
      // On détermine l'unité actuelle pour convertir vers les grammes (base DB)
      final currentUnit = UnitConverter.getSuffix(initialWeightRaw, system);
      
      final initialWeight = UnitConverter.toGrams(initialWeightRaw, currentUnit);
      final targetW = UnitConverter.toGrams(targetWeightRaw, currentUnit);
      final minDays = int.tryParse(_minSalaisonDaysController.text) ?? 4;
      
      final taxonomyRepo = ref.read(taxonomyRepositoryProvider);
      final types = await taxonomyRepo.getAllProductTypes();
      final selectedType = types.firstWhere((t) => t.id == _selectedProductTypeId);

      final pieceCompanion = PiecesCompanion.insert(
        nom: '${selectedType.label} [${_physicalIdController.text.trim()}]',
        poidsInitial: initialWeight,
        poidsCible: targetW,
        quantiteSel: UnitConverter.toGrams(double.tryParse(_saltWeightController.text) ?? 0, currentUnit),
        quantiteSucre: UnitConverter.toGrams(double.tryParse(_sugarWeightController.text) ?? 0, currentUnit),
        dateDebut: DateTime.now(),
        statut: const drift.Value('Salaison (SSV)'),
        minSalaisonDays: drift.Value(minDays),
        productTypeId: drift.Value(_selectedProductTypeId),
        physicalID: drift.Value(_physicalIdController.text.trim()),
      );

      final repository = ref.read(piecesRepositoryProvider);
      final pieceId = await repository.addPiece(pieceCompanion);

      for (var s in _spiceControllers) {
        final name = s.name.text.trim();
        if (name.isNotEmpty && name != l10n.salt && name != l10n.sugar) {
          await repository.addSpice(SpicesCompanion.insert(
            pieceId: pieceId,
            nom: name,
            quantite: UnitConverter.toGrams(double.tryParse(s.weight.text) ?? 0.0, currentUnit),
          ));
        }
      }
      
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.error}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.newPiece)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Basic Info Form
                BasicInfoForm(
                  formKey: _formKey,
                  physicalIdController: _physicalIdController,
                  initialWeightController: _initialWeightController,
                  targetWeightController: _targetWeightController,
                  targetLossController: _targetLossController,
                  minSalaisonDaysController: _minSalaisonDaysController,
                  targetWeightFocus: _targetWeightFocus,
                  targetLossFocus: _targetLossFocus,
                  selectedProductTypeId: _selectedProductTypeId,
                  onProductTypeSelected: (id) => setState(() => _selectedProductTypeId = id),
                  onInitialWeightChanged: (value) => _updateAllCalculations(),
                  onTargetLossChanged: (value) => _updateTargetWeightFromLoss(),
                  onTargetWeightChanged: (value) => _updateLossFromTargetWeight(),
                ),
                
                // Ingredients Section
                IngredientsSection(
                  saltPercentController: _saltPercentController,
                  saltWeightController: _saltWeightController,
                  sugarPercentController: _sugarPercentController,
                  sugarWeightController: _sugarWeightController,
                  saltWeightFocus: _saltWeightFocus,
                  saltPercentFocus: _saltPercentFocus,
                  sugarWeightFocus: _sugarWeightFocus,
                  sugarPercentFocus: _sugarPercentFocus,
                  spiceControllers: _spiceControllers,
                  onAddSpice: () => setState(() => _spiceControllers.add(SpiceController(n: '', w: '0.0'))),
                  onRemoveSpice: (controller) {
                    setState(() => _spiceControllers.remove(controller));
                    controller.dispose();
                  },
                  onSaltPercentChanged: (value) => _updateSaltWeightFromPercent(),
                  onSaltWeightChanged: (value) => _updateSaltPercentFromWeight(),
                  onSugarPercentChanged: (value) => _updateSugarWeightFromPercent(),
                  onSugarWeightChanged: (value) => _updateSugarPercentFromWeight(),
                ),
                
                // Actions Section
                ActionsSection(
                  onSavePiece: _savePiece,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}