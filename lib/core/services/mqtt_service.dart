import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salaison_app/features/pieces/data/database_provider.dart';

part 'mqtt_service.g.dart';

@riverpod
class MqttService extends _$MqttService {
  late MqttServerClient _client;

  @override
  FutureOr<void> build() async {
    // Initialisation si nécessaire
  }

  Future<void> publishWeighing(Piece piece, Weighing weighing, double lossPct) async {
    final settings = await ref.read(appDatabaseProvider).select(ref.read(appDatabaseProvider).mqttSettings).getSingleOrNull();
    if (settings == null || !settings.isEnabled) return;

    _client = MqttServerClient(settings.brokerIp, 'salaison_app_client');
    _client.port = settings.port;
    _client.logging(on: false);
    _client.keepAlivePeriod = 20;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('salaison_app_client')
        .startClean()
        .withWillQos(MqttQos.atMostOnce);
    
    if (settings.username.isNotEmpty) {
      connMessage.authenticateAs(settings.username, settings.password);
    }
    _client.connectionMessage = connMessage;

    try {
      await _client.connect();
      if (_client.connectionStatus!.state == MqttConnectionState.connected) {
        final topic = '${settings.topicRoot}/${piece.id}';
        final payload = jsonEncode({
          'id': piece.id,
          'type': piece.nom,
          'poids': weighing.poids,
          'perte_pourcentage': (lossPct * 100).toStringAsFixed(2),
          'etape': piece.statut,
        });

        final builder = MqttClientPayloadBuilder();
        builder.addString(payload);
        _client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
        
        // Attendre un peu pour s'assurer que le message est parti
        await Future.delayed(const Duration(milliseconds: 500));
        _client.disconnect();
      }
    } catch (e) {
      print('MQTT Error: $e');
    }
  }
}
