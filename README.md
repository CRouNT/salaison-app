# Salaison App

![Flutter](https://img.shields.io/badge/Flutter-Framework-blue.svg)
![Dart](https://img.shields.io/badge/Dart-Language-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 🎯 Présentation

**Salaison App** est un outil artisanal libre et gratuit de suivi de salaison, conçu par des artisans pour les artisans. Cette application mobile vous accompagne tout au long du processus de fabrication de vos charcuteries maison, du salage à la dégustation.

> **"L'artisanat au service du code, le code au service de l'artisanat"**

## ✨ Fonctionnalités

### 🧂 **Suivi Complet de la Salaison**
- **Création de pièces** : Enregistrez chaque pièce avec ses caractéristiques (poids initial, objectif, type de produit)
- **Ingrédients précis** : Gestion détaillée du sel, sucre et épices avec calculs automatiques
- **Progression en temps réel** : Suivi de la perte de poids et de la progression vers l'objectif

### 🔗 **Connectivité & Automatisation**
- **MQTT Integration** : Publication automatique des pesées sur votre réseau domotique
- **Home Assistant** : Compatible avec les systèmes de maison intelligente
- **Agenda** : Rappels automatiques pour les étapes clés de la salaison

### 🌍 **Internationalisation**
- **Français** 🇫🇷 | **English** 🇬🇧 | **Valencià** 🇪🇸
- **Systèmes d'unités** : Support complet du système métrique (g/kg) et impérial (oz/lb)
- **Interface accessible** : Conçue pour tous les niveaux d'expérience

### 📊 **Gestion & Analyse**
- **Archivage** : Organisation des pièces terminées et consultation historique
- **Export PDF** : Génération de rapports détaillés pour chaque pièce
- **Statistiques** : Analyse des performances et des résultats

## 🚀 Installation

### Prérequis
- Flutter SDK (version 3.0+)
- Android Studio ou VS Code avec extensions Flutter/Dart
- Appareil Android/iOS ou émulateur

### Étapes d'installation

1. **Cloner le projet**
   ```bash
   git clone https://github.com/votre-compte/salaison-app.git
   cd salaison-app
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Lancer l'application**
   ```bash
   flutter run
   ```

## 📱 Captures d'écran

![Interface principale](https://via.placeholder.com/300x600/4CAF50/FFFFFF?text=Home+Screen)
![Détails de pièce](https://via.placeholder.com/300x600/2196F3/FFFFFF?text=Piece+Details)
![Configuration MQTT](https://via.placeholder.com/300x600/FF9800/FFFFFF?text=MQTT+Setup)

*Remarque : Les captures d'écran sont à titre indicatif*

## 🔧 Configuration

### MQTT (Optionnel)
Pour activer la publication MQTT :
1. Allez dans **Paramètres** → **Home Automation (MQTT)**
2. Configurez votre broker (IP, port, identifiants)
3. Activez les publications

### Unités
Changez le système d'unités dans **Paramètres** → **Système d'unités** :
- **Métrique** : grammes et kilogrammes
- **Impérial** : onces et livres

## 🤝 Contribuer

Nous accueillons chaleureusement les contributions ! 

1. **Fork** le projet
2. Créez une branche : `git checkout -b feature/nouvelle-fonctionnalite`
3. **Commit** vos changements : `git commit -m 'Ajout de la fonctionnalité X'`
4. **Push** : `git push origin feature/nouvelle-fonctionnalite`
5. Ouvrez une **Pull Request**

## 📋 Exigences Système

- **Flutter** : 3.0+
- **Dart** : 2.17+
- **Android** : API 21+
- **iOS** : 12.0+

## 🐛 Signaler un Bug

Si vous rencontrez un problème, merci de :
1. Vérifier que ce n'est pas déjà signalé dans les [issues](../../issues)
2. Créer une nouvelle issue avec :
   - Description détaillée du problème
   - Étapes pour reproduire
   - Version de l'application et du système
   - Logs d'erreur si disponibles

## 📞 Support

- **Documentation** : [Wiki du projet](../../wiki)
- **Questions** : [Discussions](../../discussions)
- **Problèmes** : [Issues](../../issues)

## 🎁 Soutenir le Projet

### Ğ1 (Monnaie Libre)
Si cette application vous est utile, vous pouvez soutenir son développement via la monnaie libre Ğ1 :

**Adresse de don :** `à définir`

> Chaque contribution aide à maintenir l'indépendance du projet et son développement continu.

## 📄 Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

```
MIT License

Copyright (c) 2026 Salaison App

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 🙏 Remerciements

Un grand merci à toute la communauté des artisans charcutiers qui partagent leur savoir-faire et inspirent continuellement ce projet.

---

**Construit avec ❤️ par la communauté artisanale**