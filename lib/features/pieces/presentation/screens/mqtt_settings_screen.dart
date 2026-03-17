import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/database_provider.dart';
import 'package:salaison_app/core/theme/app_theme.dart';
import 'package:drift/drift.dart' as drift;
import 'package:salaison_app/l10n/generated/app_localizations.dart';

class MqttSettingsScreen extends ConsumerStatefulWidget {
  const MqttSettingsScreen({super.key});

  @override
  ConsumerState<MqttSettingsScreen> createState() => _MqttSettingsScreenState();
}

class _MqttSettingsScreenState extends ConsumerState<MqttSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brokerIpController = TextEditingController();
  final _portController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _topicRootController = TextEditingController();
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final db = ref.read(appDatabaseProvider);
    final settings = await db.select(db.mqttSettings).getSingleOrNull();
    if (settings != null) {
      _brokerIpController.text = settings.brokerIp;
      _portController.text = settings.port.toString();
      _usernameController.text = settings.username;
      _passwordController.text = settings.password;
      _topicRootController.text = settings.topicRoot;
      _isEnabled = settings.isEnabled;
      if (mounted) setState(() {});
    }
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(appDatabaseProvider);
    
    final companion = MqttSettingsCompanion(
      brokerIp: drift.Value(_brokerIpController.text),
      port: drift.Value(int.tryParse(_portController.text) ?? 1883),
      username: drift.Value(_usernameController.text),
      password: drift.Value(_passwordController.text),
      topicRoot: drift.Value(_topicRootController.text),
      isEnabled: drift.Value(_isEnabled),
    );

    final existing = await db.select(db.mqttSettings).getSingleOrNull();
    if (existing == null) {
      await db.into(db.mqttSettings).insert(companion);
    } else {
      await (db.update(db.mqttSettings)..where((t) => t.id.equals(existing.id))).write(companion);
    }

    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.mqttSettingsSaved)));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _brokerIpController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _topicRootController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.mqttSettings)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SwitchListTile(
                    title: Text(l10n.mqttStatusEnabled),
                    subtitle: Text(l10n.mqttDescription),
                    value: _isEnabled,
                    activeColor: AppTheme.vertForet,
                    onChanged: (v) => setState(() => _isEnabled = v),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _brokerIpController,
                    decoration: InputDecoration(labelText: l10n.mqttBroker, border: const OutlineInputBorder()),
                    validator: (v) => v?.isEmpty ?? true ? l10n.error : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _portController,
                    decoration: InputDecoration(labelText: l10n.mqttPort, border: const OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (v) => int.tryParse(v ?? '') == null ? l10n.error : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: l10n.mqttUsername, border: const OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: l10n.mqttPassword, border: const OutlineInputBorder()),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _topicRootController,
                    decoration: InputDecoration(labelText: l10n.mqttTopicRoot, border: const OutlineInputBorder()),
                    validator: (v) => v?.isEmpty ?? true ? l10n.error : null,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _saveSettings,
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.rougeBoeuf),
                    child: Text(l10n.mqttSaveConfig),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
