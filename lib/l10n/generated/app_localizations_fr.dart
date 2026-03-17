// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Salaison App';

  @override
  String get settings => 'Paramètres';

  @override
  String get about => 'À propos';

  @override
  String get exportData => 'Exporter les données';

  @override
  String get mqttSettings => 'Domotique (MQTT)';

  @override
  String get language => 'Langue';

  @override
  String get newPiece => 'Nouvelle Pièce';

  @override
  String get archive => 'Archives';

  @override
  String get tourDeCave => 'Tour de Cave';

  @override
  String get weighing => 'Pesée';

  @override
  String get targetWeight => 'Poids cible';

  @override
  String get initialWeight => 'Poids initial';

  @override
  String get weight => 'Poids';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get next => 'Suivant';

  @override
  String get validate => 'Valider';

  @override
  String get success => 'Succès';

  @override
  String get error => 'Erreur';

  @override
  String get ingredients => 'Ingrédients';

  @override
  String get salt => 'Sel';

  @override
  String get sugar => 'Sucre';

  @override
  String get spices => 'Épices';

  @override
  String get woodBlend => 'Mélange de bois';

  @override
  String get smokingDuration => 'Durée de fumage';

  @override
  String get days => 'jours';

  @override
  String get hours => 'h';

  @override
  String get loss => 'perte';

  @override
  String get targetLoss => '% Perte';

  @override
  String get initial => 'Initial';

  @override
  String get target => 'Cible';

  @override
  String get ready => 'PRÊT';

  @override
  String get archived => 'Archivé';

  @override
  String get deletePieceTitle => 'Supprimer la pièce ?';

  @override
  String deletePieceContent(Object name) {
    return 'Êtes-vous sûr de vouloir supprimer définitivement \"$name\" ? Cette action est irréversible.';
  }

  @override
  String get passToNextStepTitle => 'Passer à l\'étape suivante ?';

  @override
  String get passToNextStepContent =>
      'Souhaitez-vous valider cette étape et passer à la suite du processus ?';

  @override
  String get smokingTitle => 'Pesée & Fumage';

  @override
  String get smokingContent =>
      'Veuillez peser la pièce et indiquer la durée du fumage.';

  @override
  String get unitSystem => 'Système d\'unités';

  @override
  String get metric => 'Métrique (g/kg)';

  @override
  String get imperial => 'Impérial (oz/lb)';

  @override
  String get general => 'Général';

  @override
  String get localizationAppearance => 'Localisation & Apparence';

  @override
  String get connectivity => 'Connectivité';

  @override
  String get dataSecurity => 'Données & Sécurité';

  @override
  String get information => 'Informations';

  @override
  String get backupTitle => 'Fichiers de Sauvegarde';

  @override
  String get backupSubtitle => 'Exporter vers JSON';

  @override
  String get addSpice => 'Ajouter une épice';

  @override
  String get resetStandard => 'Reset standard';

  @override
  String get productType => 'Type de produit';

  @override
  String get physicalId => 'ID / Marquage Physique';

  @override
  String get minSalaisonDays => 'Temps de salaison min';

  @override
  String get launchSalaison => 'Lancer la Salaison';

  @override
  String get poidsActuel => 'Poids actuel';

  @override
  String get progressionTarget => 'Progression vers objectif';

  @override
  String get exportPdf => 'Exporter PDF';

  @override
  String get agenda => 'Agenda';

  @override
  String get noActiveSalaison => 'Aucune salaison en cours';

  @override
  String get aboutQuote => 'L\'artisanat au service du code';

  @override
  String get aboutDescription =>
      'Cette application est née d\'une passion pour la charcuterie artisanale et le logiciel libre. Elle est conçue pour être simple, robuste et respectueuse de vos données. C\'est un outil libre, créé par des artisans pour des artisans.';

  @override
  String get supportProject => 'Soutenir le projet (Ğ1)';

  @override
  String get supportDonationDescription =>
      'Si cette application vous est utile, vous pouvez soutenir son développement via la monnaie libre Ğ1 (June). Chaque don aide à maintenir le projet indépendant.';

  @override
  String get addressCopied => 'Adresse copiée !';

  @override
  String get mqttDescription => 'Envoie les pesées sur le réseau';

  @override
  String get mqttBroker => 'Broker IP / Host';

  @override
  String get mqttPort => 'Port';

  @override
  String get mqttUsername => 'Utilisateur (Optionnel)';

  @override
  String get mqttPassword => 'Mot de passe (Optionnel)';

  @override
  String get mqttTopicRoot => 'Topic Racine';

  @override
  String get mqttSaveConfig => 'Enregistrer la config';

  @override
  String get mqttStatusEnabled => 'Activer les publications MQTT';

  @override
  String get mqttSettingsSaved => 'Paramètres MQTT enregistrés';
}
