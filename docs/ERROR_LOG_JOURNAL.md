# Journal des Erreurs et Solutions

Ce journal répertorie les obstacles rencontrés durant le développement initial et les solutions appliquées.

## 1. Erreurs d'imports massives (lib/core vs lib/features/core)
- **Problème** : Confusion entre les chemins relatifs et les packages, entraînant des erreurs de compilation.
- **Solution** : Standardisation stricte sur les imports `package:salaison_app/...` pour tous les fichiers.

## 2. Échec du build avec Drift sur Linux
- **Problème** : Erreur de liaison (linker) ou dépendances manquantes (`lld`, `clang`).
- **Solution** : Installation des paquets système nécessaires :
  ```bash
  sudo apt install lld clang libgtk-3-dev
  ```

## 3. Conflit SQLite Web vs Native
- **Problème** : `sqlite3` ne fonctionne pas nativement dans le navigateur de la même façon que sur Linux/Android.
- **Solution** : Utilisation de `sqlite3_flutter_libs` et configuration d'une connexion native. (Une version Web complète nécessiterait l'installation de SQL.js).

## 4. Typage CardTheme vs CardThemeData
- **Problème** : Erreur Flutter `CardTheme is not a CardThemeData`.
- **Solution** : Correction dans `app_theme.dart` pour utiliser le constructeur correct `cardTheme: CardThemeData(...)`.
