import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:salaison_app/l10n/generated/app_localizations.dart';
import 'package:salaison_app/core/theme/app_theme.dart';
import 'package:salaison_app/core/router/app_router.dart';
import 'package:salaison_app/core/providers/language_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SalaisonApp(),
    ),
  );
}

class SalaisonApp extends ConsumerWidget {
  const SalaisonApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageNotifierProvider);
    
    return MaterialApp.router(
      title: 'Salaison App',
      theme: AppTheme.light,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
