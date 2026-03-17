# Decisions Architecturales - Salaison App

Ce document résume les choix techniques faits pour le prototype de l'application de salaison.

## Structure du Projet (Feature-First)

Le projet suit une organisation par "features" pour faciliter la maintenance et l'évolution :
- `lib/core` : Contient le code partagé (base de données, thème, router, utilitaires).
- `lib/features/pieces` : Gestion de l'affichage et du dépôt de données des pièces.
- `lib/features/creation_flow` : Logique spécifique à la création de nouvelles salaisons.

## Choix Technologiques

### 1. Drift (SQLite)
- **Pourquoi** : Nécessité d'une persistance locale robuste pour un usage hors-ligne (en cave/cuisine). Drift offre un typage fort et une génération de code automatique.
- **Alternative** : Hive (NoSQL), écarté pour la complexité des relations entre Pièces et Pesées.

### 2. Riverpod
- **Pourquoi** : Gestion d'état moderne, testable et performante. L'utilisation des générateurs (`@riverpod`) simplifie l'injection de dépendances et le rafraîchissement automatique des flux (Stream) de la base de données.

### 3. GoRouter
- **Pourquoi** : Solution standard de navigation pour Flutter, gérant nativement les paramètres d'URL (utile pour le détail d'une pièce `/piece/:id`) et offrant une configuration déclarative simple.

### 3. Précision V0.95
- **Transitions Forcées** : Le bouton de pesée manuel est bloqué au début. Chaque passage de phase (ex: Salaison -> Repos) déclenche un popup de pesée obligatoire avec étiquetage contextuel ('Sortie Salaison').
- **Recalcul de Cible** : Dès que l'étape de séchage commence, l'objectif de poids est recalculé sur la base du `preDryingWeight`. L'ancien objectif basé sur le poids cru est masqué pour éviter toute confusion.
- **Auto-remplissage** : Les recettes standard (4% sel, 2% sucre) sont pré-remplies par défaut au moment de la création pour gagner du temps.
