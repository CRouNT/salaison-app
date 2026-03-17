# Changelog

Tous les changements importants de ce projet seront documentés ici.

Le format de ce changelog est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.4] - 2026-03-17

### Ajouté
- **Nouvelle identité visuelle** : Icône de l'application générée avec flutter_launcher_icons
- **Support GitHub** : Liens vers le repository, issues et discussions dans l'application
- **Clé Cesium** : Support pour dons via monnaie libre Ğ1 affichée dans l'écran "À propos"
- **Modularisation complète** : Refactorisation des gros fichiers dépassant 300 lignes
- **Nouvelle architecture** : Séparation des dialogues en widgets individuels dans `/widgets/dialogs/`
- **Centralisation de la logique** : Création du `TransitionHelper` pour gérer les transitions entre étapes
- **Documentation complète** : Ajout de commentaires DartDoc sur tous les nouveaux widgets et services
- **Compatibilité ascendante** : Maintien de l'ancien `PieceDialogs` avec dépréciation
- **Licence MIT** : Ajout de la licence pour publication publique

### Améliorations
- **Interface "À propos"** : Ajout de liens cliquables vers GitHub et support Cesium
- **Réduction de 75%** du fichier `piece_dialogs.dart` (495 → 126 lignes)
- **Meilleure maintenabilité** : Widgets réutilisables et indépendants
- **Code plus propre** : Suppression des types `dynamic` restants
- **Structure GitHub-ready** : Organisation claire pour publication publique

### Sécurité
- **Vérification des secrets** : Aucun secret codé en dur détecté
- **Nettoyage des credentials** : Suppression des références aux credentials locaux

### Dépendances
- **flutter_launcher_icons** : Ajout de la dépendance pour la génération d'icônes
- **url_launcher** : Ajout pour la gestion des liens externes

## [1.0.3] - 2026-03-16

### Ajouté
- **Système d'unités impériales** : Support complet pour oz/lb avec affichage correct
- **Neutralité du Saumon** : Correction du type de produit Saumon pour respecter la neutralité
- **Amélioration de l'interface** : Meilleure gestion des unités dans les formulaires

### Corrigé
- **Erreurs d'arrondis** : Correction des affichages d'unités impériales
- **Validation des unités** : Meilleure conversion et affichage des poids

## [1.0.2] - 2026-03-15

### Ajouté
- **Support MQTT** : Intégration complète avec Home Assistant
- **Export PDF** : Génération de rapports détaillés pour les pièces archivées
- **Agenda** : Intégration avec le calendrier système pour les rappels

### Améliorations
- **Interface utilisateur** : Amélioration de la navigation et des retours visuels
- **Gestion des erreurs** : Meilleure gestion des erreurs réseau et système

## [1.0.1] - 2026-03-14

### Ajouté
- **Internationalisation** : Support complet français/anglais/valencien
- **Système de taxonomie** : Gestion des types de produits et épices
- **Base de données** : Structure complète avec Drift/SQLite

### Corrigé
- **Bugs mineurs** : Correction de divers bugs d'interface et de logique

## [1.0.0] - 2026-03-13

### Ajouté
- **Version initiale** : Publication de la version 1.0.0
- **Fonctionnalités de base** : Création, suivi et gestion des pièces de salaison
- **Interface complète** : Écrans de gestion, détails et archives