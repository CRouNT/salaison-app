// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Salaison App';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get exportData => 'Export Data';

  @override
  String get mqttSettings => 'Home Automation (MQTT)';

  @override
  String get language => 'Language';

  @override
  String get newPiece => 'New Product';

  @override
  String get archive => 'Archives';

  @override
  String get tourDeCave => 'Weighing Tour';

  @override
  String get weighing => 'Weighing';

  @override
  String get targetWeight => 'Target weight';

  @override
  String get initialWeight => 'Initial weight';

  @override
  String get weight => 'Weight';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get next => 'Next';

  @override
  String get validate => 'Validate';

  @override
  String get success => 'Success';

  @override
  String get error => 'Error';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get salt => 'Salt';

  @override
  String get sugar => 'Sugar';

  @override
  String get spices => 'Spices';

  @override
  String get woodBlend => 'Wood Blend';

  @override
  String get smokingDuration => 'Smoking duration';

  @override
  String get days => 'days';

  @override
  String get hours => 'h';

  @override
  String get loss => 'loss';

  @override
  String get targetLoss => 'Target Loss %';

  @override
  String get initial => 'Initial';

  @override
  String get target => 'Target';

  @override
  String get ready => 'READY';

  @override
  String get archived => 'Archived';

  @override
  String get deletePieceTitle => 'Delete product?';

  @override
  String deletePieceContent(Object name) {
    return 'Are you sure you want to permanently delete \"$name\"? This action is irreversible.';
  }

  @override
  String get passToNextStepTitle => 'Move to next step?';

  @override
  String get passToNextStepContent =>
      'Do you want to validate this step and move on to the next part of the process?';

  @override
  String get smokingTitle => 'Weight & Smoking';

  @override
  String get smokingContent =>
      'Please weigh the product and specify the smoking duration.';

  @override
  String get unitSystem => 'Unit System';

  @override
  String get metric => 'Metric (g/kg)';

  @override
  String get imperial => 'Imperial (oz/lb)';

  @override
  String get general => 'General';

  @override
  String get localizationAppearance => 'Localization & Appearance';

  @override
  String get connectivity => 'Connectivity';

  @override
  String get dataSecurity => 'Data & Security';

  @override
  String get information => 'Information';

  @override
  String get backupTitle => 'Backup Files';

  @override
  String get backupSubtitle => 'Export to JSON';

  @override
  String get addSpice => 'Add spice';

  @override
  String get resetStandard => 'Reset standard';

  @override
  String get productType => 'Product type';

  @override
  String get physicalId => 'Physical ID / ID Marking';

  @override
  String get minSalaisonDays => 'Min curing time';

  @override
  String get launchSalaison => 'Start Curing';

  @override
  String get poidsActuel => 'Current weight';

  @override
  String get progressionTarget => 'Progress towards target';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get agenda => 'Calendar';

  @override
  String get noActiveSalaison => 'No active products';

  @override
  String get aboutQuote => 'Craftsmanship at the service of code';

  @override
  String get aboutDescription =>
      'This application was born from a passion for artisanal charcuterie and free software. It is designed to be simple, robust, and respectful of your data. It is a free tool, created by artisans for artisans.';

  @override
  String get supportProject => 'Support the project (Ğ1)';

  @override
  String get supportDonationDescription =>
      'If you find this application useful, you can support its development via the Ğ1 (June) free currency. Every donation helps keep the project independent.';

  @override
  String get addressCopied => 'Address copied!';

  @override
  String get mqttDescription => 'Publishes weighings on the network';

  @override
  String get mqttBroker => 'Broker IP / Host';

  @override
  String get mqttPort => 'Port';

  @override
  String get mqttUsername => 'Username (Optional)';

  @override
  String get mqttPassword => 'Password (Optional)';

  @override
  String get mqttTopicRoot => 'Topic Root';

  @override
  String get mqttSaveConfig => 'Save config';

  @override
  String get mqttStatusEnabled => 'Enable MQTT publications';

  @override
  String get mqttSettingsSaved => 'MQTT settings saved';
}
