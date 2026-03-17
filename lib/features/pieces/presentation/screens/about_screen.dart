import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:salaison_app/core/theme/app_theme.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String _g1Address = 'DTm7ZfxbJNdR2HRGP3Vfkoq6gnyvMVbM519H9xYMTXMt';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.beigeFroid,
      appBar: AppBar(
        title: Text(l10n.about),
        backgroundColor: AppTheme.beigeFroid,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            children: [
              const Icon(Icons.auto_awesome, size: 60, color: AppTheme.rougeBoeuf),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Salaison App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.rougeBoeuf,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Version 1.0.4',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                l10n.aboutQuote,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.boisBrun),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.aboutDescription,
                style: const TextStyle(height: 1.5, fontSize: 15),
              ),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 24),
              Text(
                l10n.supportProject,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.rougeBoeuf),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.supportDonationDescription,
                style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.blueGrey),
              ),
              const SizedBox(height: 24),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.bordure),
                  ),
                  child: QrImageView(
                    data: _g1Address,
                    version: QrVersions.auto,
                    size: 180.0,
                    foregroundColor: AppTheme.graphite,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        _g1Address,
                        style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: _g1Address));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.addressCopied)),
                      );
                    },
                    color: AppTheme.rougeBoeuf,
                  ),
                ],
              ),
              const SizedBox(height: 48),
              const Center(
                child: Text(
                  '© 2026 Salaison App Team',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
