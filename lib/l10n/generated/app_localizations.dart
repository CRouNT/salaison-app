import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'Salaison App'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settings;

  /// No description provided for @about.
  ///
  /// In fr, this message translates to:
  /// **'À propos'**
  String get about;

  /// No description provided for @exportData.
  ///
  /// In fr, this message translates to:
  /// **'Exporter les données'**
  String get exportData;

  /// No description provided for @mqttSettings.
  ///
  /// In fr, this message translates to:
  /// **'Domotique (MQTT)'**
  String get mqttSettings;

  /// No description provided for @language.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get language;

  /// No description provided for @newPiece.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle Pièce'**
  String get newPiece;

  /// No description provided for @archive.
  ///
  /// In fr, this message translates to:
  /// **'Archives'**
  String get archive;

  /// No description provided for @tourDeCave.
  ///
  /// In fr, this message translates to:
  /// **'Tour de Cave'**
  String get tourDeCave;

  /// No description provided for @weighing.
  ///
  /// In fr, this message translates to:
  /// **'Pesée'**
  String get weighing;

  /// No description provided for @targetWeight.
  ///
  /// In fr, this message translates to:
  /// **'Poids cible'**
  String get targetWeight;

  /// No description provided for @initialWeight.
  ///
  /// In fr, this message translates to:
  /// **'Poids initial'**
  String get initialWeight;

  /// No description provided for @weight.
  ///
  /// In fr, this message translates to:
  /// **'Poids'**
  String get weight;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get edit;

  /// No description provided for @next.
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get next;

  /// No description provided for @validate.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get validate;

  /// No description provided for @success.
  ///
  /// In fr, this message translates to:
  /// **'Succès'**
  String get success;

  /// No description provided for @error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get error;

  /// No description provided for @ingredients.
  ///
  /// In fr, this message translates to:
  /// **'Ingrédients'**
  String get ingredients;

  /// No description provided for @salt.
  ///
  /// In fr, this message translates to:
  /// **'Sel'**
  String get salt;

  /// No description provided for @sugar.
  ///
  /// In fr, this message translates to:
  /// **'Sucre'**
  String get sugar;

  /// No description provided for @spices.
  ///
  /// In fr, this message translates to:
  /// **'Épices'**
  String get spices;

  /// No description provided for @woodBlend.
  ///
  /// In fr, this message translates to:
  /// **'Mélange de bois'**
  String get woodBlend;

  /// No description provided for @smokingDuration.
  ///
  /// In fr, this message translates to:
  /// **'Durée de fumage'**
  String get smokingDuration;

  /// No description provided for @days.
  ///
  /// In fr, this message translates to:
  /// **'jours'**
  String get days;

  /// No description provided for @hours.
  ///
  /// In fr, this message translates to:
  /// **'h'**
  String get hours;

  /// No description provided for @loss.
  ///
  /// In fr, this message translates to:
  /// **'perte'**
  String get loss;

  /// No description provided for @targetLoss.
  ///
  /// In fr, this message translates to:
  /// **'% Perte'**
  String get targetLoss;

  /// No description provided for @initial.
  ///
  /// In fr, this message translates to:
  /// **'Initial'**
  String get initial;

  /// No description provided for @target.
  ///
  /// In fr, this message translates to:
  /// **'Cible'**
  String get target;

  /// No description provided for @ready.
  ///
  /// In fr, this message translates to:
  /// **'PRÊT'**
  String get ready;

  /// No description provided for @archived.
  ///
  /// In fr, this message translates to:
  /// **'Archivé'**
  String get archived;

  /// No description provided for @deletePieceTitle.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la pièce ?'**
  String get deletePieceTitle;

  /// No description provided for @deletePieceContent.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer définitivement \"{name}\" ? Cette action est irréversible.'**
  String deletePieceContent(Object name);

  /// No description provided for @passToNextStepTitle.
  ///
  /// In fr, this message translates to:
  /// **'Passer à l\'étape suivante ?'**
  String get passToNextStepTitle;

  /// No description provided for @passToNextStepContent.
  ///
  /// In fr, this message translates to:
  /// **'Souhaitez-vous valider cette étape et passer à la suite du processus ?'**
  String get passToNextStepContent;

  /// No description provided for @smokingTitle.
  ///
  /// In fr, this message translates to:
  /// **'Pesée & Fumage'**
  String get smokingTitle;

  /// No description provided for @smokingContent.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez peser la pièce et indiquer la durée du fumage.'**
  String get smokingContent;

  /// No description provided for @unitSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système d\'unités'**
  String get unitSystem;

  /// No description provided for @metric.
  ///
  /// In fr, this message translates to:
  /// **'Métrique (g/kg)'**
  String get metric;

  /// No description provided for @imperial.
  ///
  /// In fr, this message translates to:
  /// **'Impérial (oz/lb)'**
  String get imperial;

  /// No description provided for @general.
  ///
  /// In fr, this message translates to:
  /// **'Général'**
  String get general;

  /// No description provided for @localizationAppearance.
  ///
  /// In fr, this message translates to:
  /// **'Localisation & Apparence'**
  String get localizationAppearance;

  /// No description provided for @connectivity.
  ///
  /// In fr, this message translates to:
  /// **'Connectivité'**
  String get connectivity;

  /// No description provided for @dataSecurity.
  ///
  /// In fr, this message translates to:
  /// **'Données & Sécurité'**
  String get dataSecurity;

  /// No description provided for @information.
  ///
  /// In fr, this message translates to:
  /// **'Informations'**
  String get information;

  /// No description provided for @backupTitle.
  ///
  /// In fr, this message translates to:
  /// **'Fichiers de Sauvegarde'**
  String get backupTitle;

  /// No description provided for @backupSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Exporter vers JSON'**
  String get backupSubtitle;

  /// No description provided for @addSpice.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une épice'**
  String get addSpice;

  /// No description provided for @resetStandard.
  ///
  /// In fr, this message translates to:
  /// **'Reset standard'**
  String get resetStandard;

  /// No description provided for @productType.
  ///
  /// In fr, this message translates to:
  /// **'Type de produit'**
  String get productType;

  /// No description provided for @physicalId.
  ///
  /// In fr, this message translates to:
  /// **'ID / Marquage Physique'**
  String get physicalId;

  /// No description provided for @minSalaisonDays.
  ///
  /// In fr, this message translates to:
  /// **'Temps de salaison min'**
  String get minSalaisonDays;

  /// No description provided for @launchSalaison.
  ///
  /// In fr, this message translates to:
  /// **'Lancer la Salaison'**
  String get launchSalaison;

  /// No description provided for @poidsActuel.
  ///
  /// In fr, this message translates to:
  /// **'Poids actuel'**
  String get poidsActuel;

  /// No description provided for @progressionTarget.
  ///
  /// In fr, this message translates to:
  /// **'Progression vers objectif'**
  String get progressionTarget;

  /// No description provided for @exportPdf.
  ///
  /// In fr, this message translates to:
  /// **'Exporter PDF'**
  String get exportPdf;

  /// No description provided for @agenda.
  ///
  /// In fr, this message translates to:
  /// **'Agenda'**
  String get agenda;

  /// No description provided for @noActiveSalaison.
  ///
  /// In fr, this message translates to:
  /// **'Aucune salaison en cours'**
  String get noActiveSalaison;

  /// No description provided for @aboutQuote.
  ///
  /// In fr, this message translates to:
  /// **'L\'artisanat au service du code'**
  String get aboutQuote;

  /// No description provided for @aboutDescription.
  ///
  /// In fr, this message translates to:
  /// **'Cette application est née d\'une passion pour la charcuterie artisanale et le logiciel libre. Elle est conçue pour être simple, robuste et respectueuse de vos données. C\'est un outil libre, créé par des artisans pour des artisans.'**
  String get aboutDescription;

  /// No description provided for @supportProject.
  ///
  /// In fr, this message translates to:
  /// **'Soutenir le projet (Ğ1)'**
  String get supportProject;

  /// No description provided for @supportDonationDescription.
  ///
  /// In fr, this message translates to:
  /// **'Si cette application vous est utile, vous pouvez soutenir son développement via la monnaie libre Ğ1 (June). Chaque don aide à maintenir le projet indépendant.'**
  String get supportDonationDescription;

  /// No description provided for @addressCopied.
  ///
  /// In fr, this message translates to:
  /// **'Adresse copiée !'**
  String get addressCopied;

  /// No description provided for @mqttDescription.
  ///
  /// In fr, this message translates to:
  /// **'Envoie les pesées sur le réseau'**
  String get mqttDescription;

  /// No description provided for @mqttBroker.
  ///
  /// In fr, this message translates to:
  /// **'Broker IP / Host'**
  String get mqttBroker;

  /// No description provided for @mqttPort.
  ///
  /// In fr, this message translates to:
  /// **'Port'**
  String get mqttPort;

  /// No description provided for @mqttUsername.
  ///
  /// In fr, this message translates to:
  /// **'Utilisateur (Optionnel)'**
  String get mqttUsername;

  /// No description provided for @mqttPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe (Optionnel)'**
  String get mqttPassword;

  /// No description provided for @mqttTopicRoot.
  ///
  /// In fr, this message translates to:
  /// **'Topic Racine'**
  String get mqttTopicRoot;

  /// No description provided for @mqttSaveConfig.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer la config'**
  String get mqttSaveConfig;

  /// No description provided for @mqttStatusEnabled.
  ///
  /// In fr, this message translates to:
  /// **'Activer les publications MQTT'**
  String get mqttStatusEnabled;

  /// No description provided for @mqttSettingsSaved.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres MQTT enregistrés'**
  String get mqttSettingsSaved;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ca', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return AppLocalizationsCa();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
