import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salaison_app/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/features/pieces/data/taxonomy_repository.dart';
import 'package:salaison_app/core/services/backup_service.dart';
import 'package:salaison_app/core/providers/language_provider.dart';
import 'package:salaison_app/core/utils/unit_converter.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';

/// Écran de configuration de l'application (Unité, Archives, A propos).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.boisBrun.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final system = ref.watch(unitSystemProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          _buildSection(context, l10n.general, [
            ListTile(
              leading: const Icon(Icons.archive_outlined, color: AppTheme.boisBrun),
              title: Text(l10n.archive),
              onTap: () => context.push('/archives'),
              trailing: const Icon(Icons.chevron_right, size: 18),
            ),
            ListTile(
              leading: const Icon(Icons.category_outlined, color: AppTheme.boisBrun),
              title: Text(l10n.productType),
              onTap: () => context.push('/taxonomy'),
              trailing: const Icon(Icons.chevron_right, size: 18),
            ),
          ]),
          _buildSection(context, l10n.localizationAppearance, [
            ListTile(
              leading: const Icon(Icons.language_outlined, color: AppTheme.boisBrun),
              title: Text(l10n.language),
              trailing: DropdownButton<Locale>(
                value: ref.watch(languageNotifierProvider),
                underline: const SizedBox(),
                onChanged: (value) {
                  if (value != null) {
                    ref.read(languageNotifierProvider.notifier).setLocale(value);
                  }
                },
                items: const [
                  DropdownMenuItem(value: Locale('fr'), child: Text('Français')),
                  DropdownMenuItem(value: Locale('en'), child: Text('English')),
                  DropdownMenuItem(value: Locale('ca'), child: Text('Valencian')),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.straighten_outlined, color: AppTheme.boisBrun),
              title: Text(l10n.unitSystem),
              trailing: DropdownButton<UnitSystem>(
                value: system,
                underline: const SizedBox(),
                onChanged: (value) {
                  if (value != null) {
                    ref.read(unitSystemProvider.notifier).state = value;
                  }
                },
                items: [
                  DropdownMenuItem(value: UnitSystem.metric, child: Text(l10n.metric)),
                  DropdownMenuItem(value: UnitSystem.imperial, child: Text(l10n.imperial)),
                ],
              ),
            ),
          ]),
          _buildSection(context, l10n.connectivity, [
            ListTile(
              leading: const Icon(Icons.settings_remote_outlined, color: AppTheme.boisBrun),
              title: Text(l10n.mqttSettings),
              onTap: () => context.push('/mqtt-settings'),
              trailing: const Icon(Icons.chevron_right, size: 18),
            ),
          ]),
          _buildSection(context, l10n.dataSecurity, [
            ListTile(
              leading: const Icon(Icons.backup_outlined, color: AppTheme.boisBrun),
              title: Text(l10n.backupTitle),
              subtitle: Text(l10n.backupSubtitle),
              onTap: () async {
                final backup = BackupService(
                  ref.read(piecesRepositoryProvider),
                  ref.read(taxonomyRepositoryProvider),
                );
                final path = await backup.exportData();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(path != null ? '${l10n.success} : $path' : l10n.error)),
                  );
                }
              },
            ),
          ]),
          _buildSection(context, l10n.information, [
            ListTile(
              leading: const Icon(Icons.info_outline, color: AppTheme.boisBrun),
              title: Text(l10n.about),
              onTap: () => context.push('/about'),
              trailing: const Icon(Icons.chevron_right, size: 18),
            ),
          ]),
        ],
      ),
    );
  }
}
