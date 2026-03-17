import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UnitSystem { metric, imperial }

final unitSystemProvider = StateProvider<UnitSystem>((ref) => UnitSystem.metric);

class UnitConverter {
  static const double _gToOz = 0.03527396;
  static const double _gToLb = 0.00220462;

  /// Formate un poids (en g) vers la chaîne affichable selon le système.
  static String formatWeight(double grams, UnitSystem system, {int precision = 1}) {
    if (system == UnitSystem.metric) {
      if (grams >= 1000) {
        return '${(grams / 1000).toStringAsFixed(precision)} kg';
      }
      return '${grams.toStringAsFixed(0)} g';
    } else {
      // Impérial: on affiche en oz si < 16, sinon lb/oz ? 
      // Pour faire simple comme demandé (oz/lb), on va afficher :
      // - Si < 1lb (453.6g), en oz.
      // - Sinon en lb.
      final oz = grams * _gToOz;
      if (oz < 16) {
        return '${oz.toStringAsFixed(precision)} oz';
      }
      final lb = grams * _gToLb;
      return '${lb.toStringAsFixed(precision)} lb';
    }
  }

  /// Retourne le suffixe d'unité court selon la valeur et le système.
  static String getSuffix(double grams, UnitSystem system) {
    if (system == UnitSystem.metric) {
      return grams >= 1000 ? 'kg' : 'g';
    } else {
      return grams * _gToOz >= 16 ? 'lb' : 'oz';
    }
  }

  /// Convertit une valeur saisie dans le système donné vers des grammes.
  static double toGrams(double value, String unit) {
    switch (unit.toLowerCase()) {
      case 'kg': return value * 1000;
      case 'lb': return value / _gToLb;
      case 'oz': return value / _gToOz;
      default: return value; // g
    }
  }
}
