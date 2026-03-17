// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'Salaison App';

  @override
  String get settings => 'Paràmetres';

  @override
  String get about => 'Sobre l\'app';

  @override
  String get exportData => 'Exportar dades';

  @override
  String get mqttSettings => 'Domòtica (MQTT)';

  @override
  String get language => 'Llengua';

  @override
  String get newPiece => 'Nova Peça';

  @override
  String get archive => 'Arxius';

  @override
  String get tourDeCave => 'Tour de pesatge';

  @override
  String get weighing => 'Pesatge';

  @override
  String get targetWeight => 'Pes objectiu';

  @override
  String get initialWeight => 'Pes inicial';

  @override
  String get weight => 'Pes';

  @override
  String get cancel => 'Cancel·lar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get next => 'Següent';

  @override
  String get validate => 'Validar';

  @override
  String get success => 'Èxit';

  @override
  String get error => 'Error';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get salt => 'Sal';

  @override
  String get sugar => 'Sucre';

  @override
  String get spices => 'Espècies';

  @override
  String get woodBlend => 'Mescla de fusta';

  @override
  String get smokingDuration => 'Durada del fumat';

  @override
  String get days => 'dies';

  @override
  String get hours => 'h';

  @override
  String get loss => 'pèrdua';

  @override
  String get targetLoss => '% Pèrdua';

  @override
  String get initial => 'Inicial';

  @override
  String get target => 'Objectiu';

  @override
  String get ready => 'LLEST';

  @override
  String get archived => 'Arxivat';

  @override
  String get deletePieceTitle => 'Eliminar la peça?';

  @override
  String deletePieceContent(Object name) {
    return 'Estàs segur que vols eliminar definitivament \"$name\"? Aquesta acció és irreversible.';
  }

  @override
  String get passToNextStepTitle => 'Passar a la següent etapa?';

  @override
  String get passToNextStepContent =>
      'Vols validar aquesta etapa i passar a la següent part del procés?';

  @override
  String get smokingTitle => 'Pesatge i Fumat';

  @override
  String get smokingContent =>
      'Si us plau, pesa la peça i indica la durada del fumat.';

  @override
  String get unitSystem => 'Sistema d\'unitats';

  @override
  String get metric => 'Mètric (g/kg)';

  @override
  String get imperial => 'Imperial (oz/lb)';

  @override
  String get general => 'General';

  @override
  String get localizationAppearance => 'Localització i Aparença';

  @override
  String get connectivity => 'Connectivitat';

  @override
  String get dataSecurity => 'Dades i Seguretat';

  @override
  String get information => 'Informació';

  @override
  String get backupTitle => 'Fitxers de Còpia de Seguretat';

  @override
  String get backupSubtitle => 'Exportar a JSON';

  @override
  String get addSpice => 'Afegir una espècia';

  @override
  String get resetStandard => 'Reiniciar a l\'estàndard';

  @override
  String get productType => 'Tipus de producte';

  @override
  String get physicalId => 'ID / Marcatge Físic';

  @override
  String get minSalaisonDays => 'Temps mínim de salat';

  @override
  String get launchSalaison => 'Començar el salat';

  @override
  String get poidsActuel => 'Pes actual';

  @override
  String get progressionTarget => 'Progressió cap a l\'objectiu';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get agenda => 'Agenda';

  @override
  String get noActiveSalaison => 'Cap saladura en curs';

  @override
  String get aboutQuote => 'Artesania al servei del codi';

  @override
  String get aboutDescription =>
      'Aquesta aplicació va néixer d\'una passió per la xarcuteria artesana i el programari lliure. Està dissenyada per ser senzilla, robusta i respectuosa amb les teves dades. És una eina lliure, creada per artesans per a artesans.';

  @override
  String get supportProject => 'Sostindre el projecte (Ğ1)';

  @override
  String get supportDonationDescription =>
      'Si aquesta aplicació et resulta útil, pots sostindre el seu desenvolupament a través de la moneda lliure Ğ1 (June). Cada donació ajuda a mantindre el projecte independent.';

  @override
  String get addressCopied => 'Adreça copiada!';

  @override
  String get mqttDescription => 'Envia els pesatges per la xarxa';

  @override
  String get mqttBroker => 'Broker IP / Host';

  @override
  String get mqttPort => 'Port';

  @override
  String get mqttUsername => 'Usuari (Opcional)';

  @override
  String get mqttPassword => 'Contrasenya (Opcional)';

  @override
  String get mqttTopicRoot => 'Tòpic Arrel';

  @override
  String get mqttSaveConfig => 'Guardar la config';

  @override
  String get mqttStatusEnabled => 'Activar les publicacions MQTT';

  @override
  String get mqttSettingsSaved => 'Paràmetres MQTT guardats';
}
