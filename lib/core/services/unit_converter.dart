/// Service de conversion d'unités pour les poids.
/// 
/// Ce service gère la conversion entre les systèmes métrique et impérial
/// pour les poids utilisés dans l'application de salaison.
/// 
/// Auteur: Système de génération de code
/// Date: v1.0.4
/// Licence: MIT

import 'package:salaison_app/core/providers/settings_provider.dart';

/// Service de conversion d'unités pour les poids.
class UnitConverter {
  /// Convertit un poids en grammes selon l'unité d'entrée.
  static double toGrams(double value, String unit) {
    switch (unit.toLowerCase()) {
      case 'g':
        return value;
      case 'kg':
        return value * 1000;
      case 'oz':
        return value * 28.3495;
      case 'lb':
        return value * 453.592;
      default:
        return value; // Par défaut, on suppose que c'est déjà en grammes
    }
  }

  /// Convertit un poids en grammes vers l'unité cible.
  static double fromGrams(double grams, String targetUnit) {
    switch (targetUnit.toLowerCase()) {
      case 'g':
        return grams;
      case 'kg':
        return grams / 1000;
      case 'oz':
        return grams / 28.3495;
      case 'lb':
        return grams / 453.592;
      default:
        return grams; // Par défaut, on renvoie en grammes
    }
  }

  /// Obtient le suffixe d'unité approprié selon le système d'unités.
  static String getSuffix(double value, UnitSystem system) {
    if (system == UnitSystem.imperial) {
      return value >= 1000 ? 'lb' : 'oz';
    } else {
      return value >= 1000 ? 'kg' : 'g';
    }
  }

  /// Formate un poids avec son unité appropriée.
  static String formatWeight(double grams, UnitSystem system) {
    final suffix = getSuffix(grams, system);
    final value = fromGrams(grams, suffix);
    return '${value.toStringAsFixed(1)} $suffix';
  }
}

