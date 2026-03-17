import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_provider.g.dart';

@riverpod
class LanguageNotifier extends _$LanguageNotifier {
  @override
  Locale build() {
    // Par défaut français
    return const Locale('fr');
  }

  void setLocale(Locale locale) {
    state = locale;
  }
}
