/// Fonctions utilitaires métier pour les calculs de salaison et séchage.
class SalaisonCalculations {
  /// Calcule le poids cible basé sur un poids de référence et un pourcentage de perte attendu.
  /// 
  /// @param baseWeight Le poids au début de la phase de séchage (souvent différent du poids initial).
  /// @param lossPercentage Pourcentage de perte attendu (ex: 0.35 pour 35%).
  static double calculateTargetWeight(double baseWeight, {double lossPercentage = 0.35}) {
    return baseWeight * (1 - lossPercentage);
  }

  /// Calcule le pourcentage de perte de poids actuel par rapport au poids de référence.
  static double calculateLossPercentage(double baseWeight, double currentWeight) {
    if (baseWeight == 0) return 0;
    return (baseWeight - currentWeight) / baseWeight;
  }

  /// Calcule la quantité d'un ingrédient basée sur le poids initial de la pièce.
  /// 
  /// @param initialWeight Poids total de la pièce en grammes.
  /// @param percentage Pourcentage de l'ingrédient (ex: 2.5 pour 2.5%).
  static double calculateIngredientAmount(double initialWeight, double percentage) {
    return initialWeight * (percentage / 100);
  }
}
