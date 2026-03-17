import 'package:drift/drift.dart';

/// Table représentant une pièce / produit en cours de traitement.
class Pieces extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  /// Nom donné par l'utilisateur (ex: "Jambon de Noël").
  TextColumn get nom => text()();
  
  /// Poids à l'entrée du processus (sortie du boucher).
  RealColumn get poidsInitial => real()();
  
  /// Poids de l'objectif final désiré (calculé initialement).
  RealColumn get poidsCible => real()();
  
  /// Quantité théorique de sel calculée (utilisé pour archive).
  RealColumn get quantiteSel => real()();
  
  /// Quantité théorique de sucre calculée (utilisé pour archive).
  RealColumn get quantiteSucre => real()();
  
  /// Date de mise en salaison.
  DateTimeColumn get dateDebut => dateTime()();
  
  /// Statut actuel dans le cycle (Salaison, Repos, Fumage, Séchage, Terminé).
  TextColumn get statut => text().withDefault(const Constant('Salaison (SSV)'))();
  
  /// Notes libres de l'utilisateur.
  TextColumn get notes => text().nullable()();
  
  /// Chemin local de l'image de la pièce.
  TextColumn get imagePath => text().nullable()();
  
  /// Durée minimum de salaison souhaitée (par défaut 14 jours).
  IntColumn get minSalaisonDays => integer().withDefault(const Constant(14))();
  
  /// Composition du mélange de bois pour le fumage.
  TextColumn get woodBlend => text().nullable()();
  
  /// Poids de référence juste avant le début du séchage (Poids post-repos/fumage).
  /// Utilisé pour recalculer l'objectif de perte réel en phase de séchage.
  RealColumn get preDryingWeight => real().nullable()();
  
  /// Indique si la pièce est archivée (n'apparaît plus en page d'accueil).
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  
  /// Temps total de fumage accumulé en heures.
  RealColumn get smokingDuration => real().withDefault(const Constant(0))();
  
  /// Référence au type de produit (Taxonomie).
  IntColumn get productTypeId => integer().nullable().references(ProductTypes, #id)();
  
  /// Identifiant physique (marquage frigo, ex: 'A1').
  TextColumn get physicalID => text().nullable()();
}

/// Table des types de produits pour la taxonomie.
class ProductTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  /// Label unique du type (ex: 'Magret de canard').
  TextColumn get label => text().unique()();
  
  /// Catégorie d'icône pour l'affichage.
  TextColumn get iconCategory => text().nullable()();
}

/// Table des pesées intermédiaires pour le suivi de la perte de poids.
class Weighings extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  /// Référence à la pièce concernée.
  IntColumn get pieceId => integer().references(Pieces, #id)();
  
  /// Date et heure de la pesée.
  DateTimeColumn get date => dateTime()();
  
  /// Valeur du poids enregistrée.
  RealColumn get poids => real()();
  
  /// Label du contexte de pesée (ex: "Sortie Salaison", "Séchage").
  TextColumn get label => text().nullable()();
}

/// Table des ingrédients/épices secondaires (hors sel et sucre brun calculés).
class Spices extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  /// Référence à la pièce concernée.
  IntColumn get pieceId => integer().references(Pieces, #id)();
  
  /// Nom de l'épice (ex: "Poivre noir").
  TextColumn get nom => text()();
  
  /// Quantité pesée en grammes.
  RealColumn get quantite => real()();
}

/// Table pour les paramètres MQTT.
class MqttSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get brokerIp => text().withDefault(const Constant(''))();
  IntColumn get port => integer().withDefault(const Constant(1883))();
  TextColumn get username => text().withDefault(const Constant(''))();
  TextColumn get password => text().withDefault(const Constant(''))();
  TextColumn get topicRoot => text().withDefault(const Constant('salaison'))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(false))();
}
