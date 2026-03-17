/// Providers pour la gestion des paramètres de l'application.
/// 
/// Ce fichier contient les providers Riverpod pour gérer les paramètres
/// utilisateur comme le système d'unités.
/// 
/// Auteur: Système de génération de code
/// Date: v1.0.4
/// Licence: MIT

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Système d'unités supporté.
enum UnitSystem {
  metric,
  imperial,
}

/// Provider pour le système d'unités sélectionné par l'utilisateur.
final unitSystemProvider = StateProvider<UnitSystem>((ref) => UnitSystem.metric);