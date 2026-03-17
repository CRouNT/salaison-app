// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductTypesTable extends ProductTypes
    with TableInfo<$ProductTypesTable, ProductType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _iconCategoryMeta = const VerificationMeta(
    'iconCategory',
  );
  @override
  late final GeneratedColumn<String> iconCategory = GeneratedColumn<String>(
    'icon_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, label, iconCategory];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('icon_category')) {
      context.handle(
        _iconCategoryMeta,
        iconCategory.isAcceptableOrUnknown(
          data['icon_category']!,
          _iconCategoryMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      iconCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_category'],
      ),
    );
  }

  @override
  $ProductTypesTable createAlias(String alias) {
    return $ProductTypesTable(attachedDatabase, alias);
  }
}

class ProductType extends DataClass implements Insertable<ProductType> {
  final int id;

  /// Label unique du type (ex: 'Magret de canard').
  final String label;

  /// Catégorie d'icône pour l'affichage.
  final String? iconCategory;
  const ProductType({required this.id, required this.label, this.iconCategory});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || iconCategory != null) {
      map['icon_category'] = Variable<String>(iconCategory);
    }
    return map;
  }

  ProductTypesCompanion toCompanion(bool nullToAbsent) {
    return ProductTypesCompanion(
      id: Value(id),
      label: Value(label),
      iconCategory: iconCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(iconCategory),
    );
  }

  factory ProductType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductType(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      iconCategory: serializer.fromJson<String?>(json['iconCategory']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'iconCategory': serializer.toJson<String?>(iconCategory),
    };
  }

  ProductType copyWith({
    int? id,
    String? label,
    Value<String?> iconCategory = const Value.absent(),
  }) => ProductType(
    id: id ?? this.id,
    label: label ?? this.label,
    iconCategory: iconCategory.present ? iconCategory.value : this.iconCategory,
  );
  ProductType copyWithCompanion(ProductTypesCompanion data) {
    return ProductType(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      iconCategory: data.iconCategory.present
          ? data.iconCategory.value
          : this.iconCategory,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductType(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('iconCategory: $iconCategory')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, iconCategory);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductType &&
          other.id == this.id &&
          other.label == this.label &&
          other.iconCategory == this.iconCategory);
}

class ProductTypesCompanion extends UpdateCompanion<ProductType> {
  final Value<int> id;
  final Value<String> label;
  final Value<String?> iconCategory;
  const ProductTypesCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.iconCategory = const Value.absent(),
  });
  ProductTypesCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    this.iconCategory = const Value.absent(),
  }) : label = Value(label);
  static Insertable<ProductType> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<String>? iconCategory,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (iconCategory != null) 'icon_category': iconCategory,
    });
  }

  ProductTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? label,
    Value<String?>? iconCategory,
  }) {
    return ProductTypesCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      iconCategory: iconCategory ?? this.iconCategory,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (iconCategory.present) {
      map['icon_category'] = Variable<String>(iconCategory.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTypesCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('iconCategory: $iconCategory')
          ..write(')'))
        .toString();
  }
}

class $PiecesTable extends Pieces with TableInfo<$PiecesTable, Piece> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PiecesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _poidsInitialMeta = const VerificationMeta(
    'poidsInitial',
  );
  @override
  late final GeneratedColumn<double> poidsInitial = GeneratedColumn<double>(
    'poids_initial',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _poidsCibleMeta = const VerificationMeta(
    'poidsCible',
  );
  @override
  late final GeneratedColumn<double> poidsCible = GeneratedColumn<double>(
    'poids_cible',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantiteSelMeta = const VerificationMeta(
    'quantiteSel',
  );
  @override
  late final GeneratedColumn<double> quantiteSel = GeneratedColumn<double>(
    'quantite_sel',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantiteSucreMeta = const VerificationMeta(
    'quantiteSucre',
  );
  @override
  late final GeneratedColumn<double> quantiteSucre = GeneratedColumn<double>(
    'quantite_sucre',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateDebutMeta = const VerificationMeta(
    'dateDebut',
  );
  @override
  late final GeneratedColumn<DateTime> dateDebut = GeneratedColumn<DateTime>(
    'date_debut',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statutMeta = const VerificationMeta('statut');
  @override
  late final GeneratedColumn<String> statut = GeneratedColumn<String>(
    'statut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Salaison (SSV)'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minSalaisonDaysMeta = const VerificationMeta(
    'minSalaisonDays',
  );
  @override
  late final GeneratedColumn<int> minSalaisonDays = GeneratedColumn<int>(
    'min_salaison_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(14),
  );
  static const VerificationMeta _woodBlendMeta = const VerificationMeta(
    'woodBlend',
  );
  @override
  late final GeneratedColumn<String> woodBlend = GeneratedColumn<String>(
    'wood_blend',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preDryingWeightMeta = const VerificationMeta(
    'preDryingWeight',
  );
  @override
  late final GeneratedColumn<double> preDryingWeight = GeneratedColumn<double>(
    'pre_drying_weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _smokingDurationMeta = const VerificationMeta(
    'smokingDuration',
  );
  @override
  late final GeneratedColumn<double> smokingDuration = GeneratedColumn<double>(
    'smoking_duration',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _productTypeIdMeta = const VerificationMeta(
    'productTypeId',
  );
  @override
  late final GeneratedColumn<int> productTypeId = GeneratedColumn<int>(
    'product_type_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product_types (id)',
    ),
  );
  static const VerificationMeta _physicalIDMeta = const VerificationMeta(
    'physicalID',
  );
  @override
  late final GeneratedColumn<String> physicalID = GeneratedColumn<String>(
    'physical_i_d',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nom,
    poidsInitial,
    poidsCible,
    quantiteSel,
    quantiteSucre,
    dateDebut,
    statut,
    notes,
    imagePath,
    minSalaisonDays,
    woodBlend,
    preDryingWeight,
    isArchived,
    smokingDuration,
    productTypeId,
    physicalID,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pieces';
  @override
  VerificationContext validateIntegrity(
    Insertable<Piece> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('poids_initial')) {
      context.handle(
        _poidsInitialMeta,
        poidsInitial.isAcceptableOrUnknown(
          data['poids_initial']!,
          _poidsInitialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_poidsInitialMeta);
    }
    if (data.containsKey('poids_cible')) {
      context.handle(
        _poidsCibleMeta,
        poidsCible.isAcceptableOrUnknown(data['poids_cible']!, _poidsCibleMeta),
      );
    } else if (isInserting) {
      context.missing(_poidsCibleMeta);
    }
    if (data.containsKey('quantite_sel')) {
      context.handle(
        _quantiteSelMeta,
        quantiteSel.isAcceptableOrUnknown(
          data['quantite_sel']!,
          _quantiteSelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantiteSelMeta);
    }
    if (data.containsKey('quantite_sucre')) {
      context.handle(
        _quantiteSucreMeta,
        quantiteSucre.isAcceptableOrUnknown(
          data['quantite_sucre']!,
          _quantiteSucreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantiteSucreMeta);
    }
    if (data.containsKey('date_debut')) {
      context.handle(
        _dateDebutMeta,
        dateDebut.isAcceptableOrUnknown(data['date_debut']!, _dateDebutMeta),
      );
    } else if (isInserting) {
      context.missing(_dateDebutMeta);
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('min_salaison_days')) {
      context.handle(
        _minSalaisonDaysMeta,
        minSalaisonDays.isAcceptableOrUnknown(
          data['min_salaison_days']!,
          _minSalaisonDaysMeta,
        ),
      );
    }
    if (data.containsKey('wood_blend')) {
      context.handle(
        _woodBlendMeta,
        woodBlend.isAcceptableOrUnknown(data['wood_blend']!, _woodBlendMeta),
      );
    }
    if (data.containsKey('pre_drying_weight')) {
      context.handle(
        _preDryingWeightMeta,
        preDryingWeight.isAcceptableOrUnknown(
          data['pre_drying_weight']!,
          _preDryingWeightMeta,
        ),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('smoking_duration')) {
      context.handle(
        _smokingDurationMeta,
        smokingDuration.isAcceptableOrUnknown(
          data['smoking_duration']!,
          _smokingDurationMeta,
        ),
      );
    }
    if (data.containsKey('product_type_id')) {
      context.handle(
        _productTypeIdMeta,
        productTypeId.isAcceptableOrUnknown(
          data['product_type_id']!,
          _productTypeIdMeta,
        ),
      );
    }
    if (data.containsKey('physical_i_d')) {
      context.handle(
        _physicalIDMeta,
        physicalID.isAcceptableOrUnknown(
          data['physical_i_d']!,
          _physicalIDMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Piece map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Piece(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      poidsInitial: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}poids_initial'],
      )!,
      poidsCible: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}poids_cible'],
      )!,
      quantiteSel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantite_sel'],
      )!,
      quantiteSucre: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantite_sucre'],
      )!,
      dateDebut: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_debut'],
      )!,
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      minSalaisonDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_salaison_days'],
      )!,
      woodBlend: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wood_blend'],
      ),
      preDryingWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pre_drying_weight'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      smokingDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}smoking_duration'],
      )!,
      productTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_type_id'],
      ),
      physicalID: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}physical_i_d'],
      ),
    );
  }

  @override
  $PiecesTable createAlias(String alias) {
    return $PiecesTable(attachedDatabase, alias);
  }
}

class Piece extends DataClass implements Insertable<Piece> {
  final int id;

  /// Nom donné par l'utilisateur (ex: "Jambon de Noël").
  final String nom;

  /// Poids à l'entrée du processus (sortie du boucher).
  final double poidsInitial;

  /// Poids de l'objectif final désiré (calculé initialement).
  final double poidsCible;

  /// Quantité théorique de sel calculée (utilisé pour archive).
  final double quantiteSel;

  /// Quantité théorique de sucre calculée (utilisé pour archive).
  final double quantiteSucre;

  /// Date de mise en salaison.
  final DateTime dateDebut;

  /// Statut actuel dans le cycle (Salaison, Repos, Fumage, Séchage, Terminé).
  final String statut;

  /// Notes libres de l'utilisateur.
  final String? notes;

  /// Chemin local de l'image de la pièce.
  final String? imagePath;

  /// Durée minimum de salaison souhaitée (par défaut 14 jours).
  final int minSalaisonDays;

  /// Composition du mélange de bois pour le fumage.
  final String? woodBlend;

  /// Poids de référence juste avant le début du séchage (Poids post-repos/fumage).
  /// Utilisé pour recalculer l'objectif de perte réel en phase de séchage.
  final double? preDryingWeight;

  /// Indique si la pièce est archivée (n'apparaît plus en page d'accueil).
  final bool isArchived;

  /// Temps total de fumage accumulé en heures.
  final double smokingDuration;

  /// Référence au type de produit (Taxonomie).
  final int? productTypeId;

  /// Identifiant physique (marquage frigo, ex: 'A1').
  final String? physicalID;
  const Piece({
    required this.id,
    required this.nom,
    required this.poidsInitial,
    required this.poidsCible,
    required this.quantiteSel,
    required this.quantiteSucre,
    required this.dateDebut,
    required this.statut,
    this.notes,
    this.imagePath,
    required this.minSalaisonDays,
    this.woodBlend,
    this.preDryingWeight,
    required this.isArchived,
    required this.smokingDuration,
    this.productTypeId,
    this.physicalID,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nom'] = Variable<String>(nom);
    map['poids_initial'] = Variable<double>(poidsInitial);
    map['poids_cible'] = Variable<double>(poidsCible);
    map['quantite_sel'] = Variable<double>(quantiteSel);
    map['quantite_sucre'] = Variable<double>(quantiteSucre);
    map['date_debut'] = Variable<DateTime>(dateDebut);
    map['statut'] = Variable<String>(statut);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['min_salaison_days'] = Variable<int>(minSalaisonDays);
    if (!nullToAbsent || woodBlend != null) {
      map['wood_blend'] = Variable<String>(woodBlend);
    }
    if (!nullToAbsent || preDryingWeight != null) {
      map['pre_drying_weight'] = Variable<double>(preDryingWeight);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['smoking_duration'] = Variable<double>(smokingDuration);
    if (!nullToAbsent || productTypeId != null) {
      map['product_type_id'] = Variable<int>(productTypeId);
    }
    if (!nullToAbsent || physicalID != null) {
      map['physical_i_d'] = Variable<String>(physicalID);
    }
    return map;
  }

  PiecesCompanion toCompanion(bool nullToAbsent) {
    return PiecesCompanion(
      id: Value(id),
      nom: Value(nom),
      poidsInitial: Value(poidsInitial),
      poidsCible: Value(poidsCible),
      quantiteSel: Value(quantiteSel),
      quantiteSucre: Value(quantiteSucre),
      dateDebut: Value(dateDebut),
      statut: Value(statut),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      minSalaisonDays: Value(minSalaisonDays),
      woodBlend: woodBlend == null && nullToAbsent
          ? const Value.absent()
          : Value(woodBlend),
      preDryingWeight: preDryingWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(preDryingWeight),
      isArchived: Value(isArchived),
      smokingDuration: Value(smokingDuration),
      productTypeId: productTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(productTypeId),
      physicalID: physicalID == null && nullToAbsent
          ? const Value.absent()
          : Value(physicalID),
    );
  }

  factory Piece.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Piece(
      id: serializer.fromJson<int>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      poidsInitial: serializer.fromJson<double>(json['poidsInitial']),
      poidsCible: serializer.fromJson<double>(json['poidsCible']),
      quantiteSel: serializer.fromJson<double>(json['quantiteSel']),
      quantiteSucre: serializer.fromJson<double>(json['quantiteSucre']),
      dateDebut: serializer.fromJson<DateTime>(json['dateDebut']),
      statut: serializer.fromJson<String>(json['statut']),
      notes: serializer.fromJson<String?>(json['notes']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      minSalaisonDays: serializer.fromJson<int>(json['minSalaisonDays']),
      woodBlend: serializer.fromJson<String?>(json['woodBlend']),
      preDryingWeight: serializer.fromJson<double?>(json['preDryingWeight']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      smokingDuration: serializer.fromJson<double>(json['smokingDuration']),
      productTypeId: serializer.fromJson<int?>(json['productTypeId']),
      physicalID: serializer.fromJson<String?>(json['physicalID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nom': serializer.toJson<String>(nom),
      'poidsInitial': serializer.toJson<double>(poidsInitial),
      'poidsCible': serializer.toJson<double>(poidsCible),
      'quantiteSel': serializer.toJson<double>(quantiteSel),
      'quantiteSucre': serializer.toJson<double>(quantiteSucre),
      'dateDebut': serializer.toJson<DateTime>(dateDebut),
      'statut': serializer.toJson<String>(statut),
      'notes': serializer.toJson<String?>(notes),
      'imagePath': serializer.toJson<String?>(imagePath),
      'minSalaisonDays': serializer.toJson<int>(minSalaisonDays),
      'woodBlend': serializer.toJson<String?>(woodBlend),
      'preDryingWeight': serializer.toJson<double?>(preDryingWeight),
      'isArchived': serializer.toJson<bool>(isArchived),
      'smokingDuration': serializer.toJson<double>(smokingDuration),
      'productTypeId': serializer.toJson<int?>(productTypeId),
      'physicalID': serializer.toJson<String?>(physicalID),
    };
  }

  Piece copyWith({
    int? id,
    String? nom,
    double? poidsInitial,
    double? poidsCible,
    double? quantiteSel,
    double? quantiteSucre,
    DateTime? dateDebut,
    String? statut,
    Value<String?> notes = const Value.absent(),
    Value<String?> imagePath = const Value.absent(),
    int? minSalaisonDays,
    Value<String?> woodBlend = const Value.absent(),
    Value<double?> preDryingWeight = const Value.absent(),
    bool? isArchived,
    double? smokingDuration,
    Value<int?> productTypeId = const Value.absent(),
    Value<String?> physicalID = const Value.absent(),
  }) => Piece(
    id: id ?? this.id,
    nom: nom ?? this.nom,
    poidsInitial: poidsInitial ?? this.poidsInitial,
    poidsCible: poidsCible ?? this.poidsCible,
    quantiteSel: quantiteSel ?? this.quantiteSel,
    quantiteSucre: quantiteSucre ?? this.quantiteSucre,
    dateDebut: dateDebut ?? this.dateDebut,
    statut: statut ?? this.statut,
    notes: notes.present ? notes.value : this.notes,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    minSalaisonDays: minSalaisonDays ?? this.minSalaisonDays,
    woodBlend: woodBlend.present ? woodBlend.value : this.woodBlend,
    preDryingWeight: preDryingWeight.present
        ? preDryingWeight.value
        : this.preDryingWeight,
    isArchived: isArchived ?? this.isArchived,
    smokingDuration: smokingDuration ?? this.smokingDuration,
    productTypeId: productTypeId.present
        ? productTypeId.value
        : this.productTypeId,
    physicalID: physicalID.present ? physicalID.value : this.physicalID,
  );
  Piece copyWithCompanion(PiecesCompanion data) {
    return Piece(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      poidsInitial: data.poidsInitial.present
          ? data.poidsInitial.value
          : this.poidsInitial,
      poidsCible: data.poidsCible.present
          ? data.poidsCible.value
          : this.poidsCible,
      quantiteSel: data.quantiteSel.present
          ? data.quantiteSel.value
          : this.quantiteSel,
      quantiteSucre: data.quantiteSucre.present
          ? data.quantiteSucre.value
          : this.quantiteSucre,
      dateDebut: data.dateDebut.present ? data.dateDebut.value : this.dateDebut,
      statut: data.statut.present ? data.statut.value : this.statut,
      notes: data.notes.present ? data.notes.value : this.notes,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      minSalaisonDays: data.minSalaisonDays.present
          ? data.minSalaisonDays.value
          : this.minSalaisonDays,
      woodBlend: data.woodBlend.present ? data.woodBlend.value : this.woodBlend,
      preDryingWeight: data.preDryingWeight.present
          ? data.preDryingWeight.value
          : this.preDryingWeight,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      smokingDuration: data.smokingDuration.present
          ? data.smokingDuration.value
          : this.smokingDuration,
      productTypeId: data.productTypeId.present
          ? data.productTypeId.value
          : this.productTypeId,
      physicalID: data.physicalID.present
          ? data.physicalID.value
          : this.physicalID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Piece(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('poidsInitial: $poidsInitial, ')
          ..write('poidsCible: $poidsCible, ')
          ..write('quantiteSel: $quantiteSel, ')
          ..write('quantiteSucre: $quantiteSucre, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('statut: $statut, ')
          ..write('notes: $notes, ')
          ..write('imagePath: $imagePath, ')
          ..write('minSalaisonDays: $minSalaisonDays, ')
          ..write('woodBlend: $woodBlend, ')
          ..write('preDryingWeight: $preDryingWeight, ')
          ..write('isArchived: $isArchived, ')
          ..write('smokingDuration: $smokingDuration, ')
          ..write('productTypeId: $productTypeId, ')
          ..write('physicalID: $physicalID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nom,
    poidsInitial,
    poidsCible,
    quantiteSel,
    quantiteSucre,
    dateDebut,
    statut,
    notes,
    imagePath,
    minSalaisonDays,
    woodBlend,
    preDryingWeight,
    isArchived,
    smokingDuration,
    productTypeId,
    physicalID,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Piece &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.poidsInitial == this.poidsInitial &&
          other.poidsCible == this.poidsCible &&
          other.quantiteSel == this.quantiteSel &&
          other.quantiteSucre == this.quantiteSucre &&
          other.dateDebut == this.dateDebut &&
          other.statut == this.statut &&
          other.notes == this.notes &&
          other.imagePath == this.imagePath &&
          other.minSalaisonDays == this.minSalaisonDays &&
          other.woodBlend == this.woodBlend &&
          other.preDryingWeight == this.preDryingWeight &&
          other.isArchived == this.isArchived &&
          other.smokingDuration == this.smokingDuration &&
          other.productTypeId == this.productTypeId &&
          other.physicalID == this.physicalID);
}

class PiecesCompanion extends UpdateCompanion<Piece> {
  final Value<int> id;
  final Value<String> nom;
  final Value<double> poidsInitial;
  final Value<double> poidsCible;
  final Value<double> quantiteSel;
  final Value<double> quantiteSucre;
  final Value<DateTime> dateDebut;
  final Value<String> statut;
  final Value<String?> notes;
  final Value<String?> imagePath;
  final Value<int> minSalaisonDays;
  final Value<String?> woodBlend;
  final Value<double?> preDryingWeight;
  final Value<bool> isArchived;
  final Value<double> smokingDuration;
  final Value<int?> productTypeId;
  final Value<String?> physicalID;
  const PiecesCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.poidsInitial = const Value.absent(),
    this.poidsCible = const Value.absent(),
    this.quantiteSel = const Value.absent(),
    this.quantiteSucre = const Value.absent(),
    this.dateDebut = const Value.absent(),
    this.statut = const Value.absent(),
    this.notes = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.minSalaisonDays = const Value.absent(),
    this.woodBlend = const Value.absent(),
    this.preDryingWeight = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.smokingDuration = const Value.absent(),
    this.productTypeId = const Value.absent(),
    this.physicalID = const Value.absent(),
  });
  PiecesCompanion.insert({
    this.id = const Value.absent(),
    required String nom,
    required double poidsInitial,
    required double poidsCible,
    required double quantiteSel,
    required double quantiteSucre,
    required DateTime dateDebut,
    this.statut = const Value.absent(),
    this.notes = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.minSalaisonDays = const Value.absent(),
    this.woodBlend = const Value.absent(),
    this.preDryingWeight = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.smokingDuration = const Value.absent(),
    this.productTypeId = const Value.absent(),
    this.physicalID = const Value.absent(),
  }) : nom = Value(nom),
       poidsInitial = Value(poidsInitial),
       poidsCible = Value(poidsCible),
       quantiteSel = Value(quantiteSel),
       quantiteSucre = Value(quantiteSucre),
       dateDebut = Value(dateDebut);
  static Insertable<Piece> custom({
    Expression<int>? id,
    Expression<String>? nom,
    Expression<double>? poidsInitial,
    Expression<double>? poidsCible,
    Expression<double>? quantiteSel,
    Expression<double>? quantiteSucre,
    Expression<DateTime>? dateDebut,
    Expression<String>? statut,
    Expression<String>? notes,
    Expression<String>? imagePath,
    Expression<int>? minSalaisonDays,
    Expression<String>? woodBlend,
    Expression<double>? preDryingWeight,
    Expression<bool>? isArchived,
    Expression<double>? smokingDuration,
    Expression<int>? productTypeId,
    Expression<String>? physicalID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (poidsInitial != null) 'poids_initial': poidsInitial,
      if (poidsCible != null) 'poids_cible': poidsCible,
      if (quantiteSel != null) 'quantite_sel': quantiteSel,
      if (quantiteSucre != null) 'quantite_sucre': quantiteSucre,
      if (dateDebut != null) 'date_debut': dateDebut,
      if (statut != null) 'statut': statut,
      if (notes != null) 'notes': notes,
      if (imagePath != null) 'image_path': imagePath,
      if (minSalaisonDays != null) 'min_salaison_days': minSalaisonDays,
      if (woodBlend != null) 'wood_blend': woodBlend,
      if (preDryingWeight != null) 'pre_drying_weight': preDryingWeight,
      if (isArchived != null) 'is_archived': isArchived,
      if (smokingDuration != null) 'smoking_duration': smokingDuration,
      if (productTypeId != null) 'product_type_id': productTypeId,
      if (physicalID != null) 'physical_i_d': physicalID,
    });
  }

  PiecesCompanion copyWith({
    Value<int>? id,
    Value<String>? nom,
    Value<double>? poidsInitial,
    Value<double>? poidsCible,
    Value<double>? quantiteSel,
    Value<double>? quantiteSucre,
    Value<DateTime>? dateDebut,
    Value<String>? statut,
    Value<String?>? notes,
    Value<String?>? imagePath,
    Value<int>? minSalaisonDays,
    Value<String?>? woodBlend,
    Value<double?>? preDryingWeight,
    Value<bool>? isArchived,
    Value<double>? smokingDuration,
    Value<int?>? productTypeId,
    Value<String?>? physicalID,
  }) {
    return PiecesCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      poidsInitial: poidsInitial ?? this.poidsInitial,
      poidsCible: poidsCible ?? this.poidsCible,
      quantiteSel: quantiteSel ?? this.quantiteSel,
      quantiteSucre: quantiteSucre ?? this.quantiteSucre,
      dateDebut: dateDebut ?? this.dateDebut,
      statut: statut ?? this.statut,
      notes: notes ?? this.notes,
      imagePath: imagePath ?? this.imagePath,
      minSalaisonDays: minSalaisonDays ?? this.minSalaisonDays,
      woodBlend: woodBlend ?? this.woodBlend,
      preDryingWeight: preDryingWeight ?? this.preDryingWeight,
      isArchived: isArchived ?? this.isArchived,
      smokingDuration: smokingDuration ?? this.smokingDuration,
      productTypeId: productTypeId ?? this.productTypeId,
      physicalID: physicalID ?? this.physicalID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (poidsInitial.present) {
      map['poids_initial'] = Variable<double>(poidsInitial.value);
    }
    if (poidsCible.present) {
      map['poids_cible'] = Variable<double>(poidsCible.value);
    }
    if (quantiteSel.present) {
      map['quantite_sel'] = Variable<double>(quantiteSel.value);
    }
    if (quantiteSucre.present) {
      map['quantite_sucre'] = Variable<double>(quantiteSucre.value);
    }
    if (dateDebut.present) {
      map['date_debut'] = Variable<DateTime>(dateDebut.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (minSalaisonDays.present) {
      map['min_salaison_days'] = Variable<int>(minSalaisonDays.value);
    }
    if (woodBlend.present) {
      map['wood_blend'] = Variable<String>(woodBlend.value);
    }
    if (preDryingWeight.present) {
      map['pre_drying_weight'] = Variable<double>(preDryingWeight.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (smokingDuration.present) {
      map['smoking_duration'] = Variable<double>(smokingDuration.value);
    }
    if (productTypeId.present) {
      map['product_type_id'] = Variable<int>(productTypeId.value);
    }
    if (physicalID.present) {
      map['physical_i_d'] = Variable<String>(physicalID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PiecesCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('poidsInitial: $poidsInitial, ')
          ..write('poidsCible: $poidsCible, ')
          ..write('quantiteSel: $quantiteSel, ')
          ..write('quantiteSucre: $quantiteSucre, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('statut: $statut, ')
          ..write('notes: $notes, ')
          ..write('imagePath: $imagePath, ')
          ..write('minSalaisonDays: $minSalaisonDays, ')
          ..write('woodBlend: $woodBlend, ')
          ..write('preDryingWeight: $preDryingWeight, ')
          ..write('isArchived: $isArchived, ')
          ..write('smokingDuration: $smokingDuration, ')
          ..write('productTypeId: $productTypeId, ')
          ..write('physicalID: $physicalID')
          ..write(')'))
        .toString();
  }
}

class $WeighingsTable extends Weighings
    with TableInfo<$WeighingsTable, Weighing> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeighingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pieceIdMeta = const VerificationMeta(
    'pieceId',
  );
  @override
  late final GeneratedColumn<int> pieceId = GeneratedColumn<int>(
    'piece_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pieces (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _poidsMeta = const VerificationMeta('poids');
  @override
  late final GeneratedColumn<double> poids = GeneratedColumn<double>(
    'poids',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, pieceId, date, poids, label];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weighings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Weighing> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('piece_id')) {
      context.handle(
        _pieceIdMeta,
        pieceId.isAcceptableOrUnknown(data['piece_id']!, _pieceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pieceIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('poids')) {
      context.handle(
        _poidsMeta,
        poids.isAcceptableOrUnknown(data['poids']!, _poidsMeta),
      );
    } else if (isInserting) {
      context.missing(_poidsMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Weighing map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Weighing(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pieceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}piece_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      poids: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}poids'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
    );
  }

  @override
  $WeighingsTable createAlias(String alias) {
    return $WeighingsTable(attachedDatabase, alias);
  }
}

class Weighing extends DataClass implements Insertable<Weighing> {
  final int id;

  /// Référence à la pièce concernée.
  final int pieceId;

  /// Date et heure de la pesée.
  final DateTime date;

  /// Valeur du poids enregistrée.
  final double poids;

  /// Label du contexte de pesée (ex: "Sortie Salaison", "Séchage").
  final String? label;
  const Weighing({
    required this.id,
    required this.pieceId,
    required this.date,
    required this.poids,
    this.label,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['piece_id'] = Variable<int>(pieceId);
    map['date'] = Variable<DateTime>(date);
    map['poids'] = Variable<double>(poids);
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    return map;
  }

  WeighingsCompanion toCompanion(bool nullToAbsent) {
    return WeighingsCompanion(
      id: Value(id),
      pieceId: Value(pieceId),
      date: Value(date),
      poids: Value(poids),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
    );
  }

  factory Weighing.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Weighing(
      id: serializer.fromJson<int>(json['id']),
      pieceId: serializer.fromJson<int>(json['pieceId']),
      date: serializer.fromJson<DateTime>(json['date']),
      poids: serializer.fromJson<double>(json['poids']),
      label: serializer.fromJson<String?>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pieceId': serializer.toJson<int>(pieceId),
      'date': serializer.toJson<DateTime>(date),
      'poids': serializer.toJson<double>(poids),
      'label': serializer.toJson<String?>(label),
    };
  }

  Weighing copyWith({
    int? id,
    int? pieceId,
    DateTime? date,
    double? poids,
    Value<String?> label = const Value.absent(),
  }) => Weighing(
    id: id ?? this.id,
    pieceId: pieceId ?? this.pieceId,
    date: date ?? this.date,
    poids: poids ?? this.poids,
    label: label.present ? label.value : this.label,
  );
  Weighing copyWithCompanion(WeighingsCompanion data) {
    return Weighing(
      id: data.id.present ? data.id.value : this.id,
      pieceId: data.pieceId.present ? data.pieceId.value : this.pieceId,
      date: data.date.present ? data.date.value : this.date,
      poids: data.poids.present ? data.poids.value : this.poids,
      label: data.label.present ? data.label.value : this.label,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Weighing(')
          ..write('id: $id, ')
          ..write('pieceId: $pieceId, ')
          ..write('date: $date, ')
          ..write('poids: $poids, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pieceId, date, poids, label);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Weighing &&
          other.id == this.id &&
          other.pieceId == this.pieceId &&
          other.date == this.date &&
          other.poids == this.poids &&
          other.label == this.label);
}

class WeighingsCompanion extends UpdateCompanion<Weighing> {
  final Value<int> id;
  final Value<int> pieceId;
  final Value<DateTime> date;
  final Value<double> poids;
  final Value<String?> label;
  const WeighingsCompanion({
    this.id = const Value.absent(),
    this.pieceId = const Value.absent(),
    this.date = const Value.absent(),
    this.poids = const Value.absent(),
    this.label = const Value.absent(),
  });
  WeighingsCompanion.insert({
    this.id = const Value.absent(),
    required int pieceId,
    required DateTime date,
    required double poids,
    this.label = const Value.absent(),
  }) : pieceId = Value(pieceId),
       date = Value(date),
       poids = Value(poids);
  static Insertable<Weighing> custom({
    Expression<int>? id,
    Expression<int>? pieceId,
    Expression<DateTime>? date,
    Expression<double>? poids,
    Expression<String>? label,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pieceId != null) 'piece_id': pieceId,
      if (date != null) 'date': date,
      if (poids != null) 'poids': poids,
      if (label != null) 'label': label,
    });
  }

  WeighingsCompanion copyWith({
    Value<int>? id,
    Value<int>? pieceId,
    Value<DateTime>? date,
    Value<double>? poids,
    Value<String?>? label,
  }) {
    return WeighingsCompanion(
      id: id ?? this.id,
      pieceId: pieceId ?? this.pieceId,
      date: date ?? this.date,
      poids: poids ?? this.poids,
      label: label ?? this.label,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pieceId.present) {
      map['piece_id'] = Variable<int>(pieceId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (poids.present) {
      map['poids'] = Variable<double>(poids.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeighingsCompanion(')
          ..write('id: $id, ')
          ..write('pieceId: $pieceId, ')
          ..write('date: $date, ')
          ..write('poids: $poids, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }
}

class $SpicesTable extends Spices with TableInfo<$SpicesTable, Spice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pieceIdMeta = const VerificationMeta(
    'pieceId',
  );
  @override
  late final GeneratedColumn<int> pieceId = GeneratedColumn<int>(
    'piece_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pieces (id)',
    ),
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantiteMeta = const VerificationMeta(
    'quantite',
  );
  @override
  late final GeneratedColumn<double> quantite = GeneratedColumn<double>(
    'quantite',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, pieceId, nom, quantite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Spice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('piece_id')) {
      context.handle(
        _pieceIdMeta,
        pieceId.isAcceptableOrUnknown(data['piece_id']!, _pieceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pieceIdMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('quantite')) {
      context.handle(
        _quantiteMeta,
        quantite.isAcceptableOrUnknown(data['quantite']!, _quantiteMeta),
      );
    } else if (isInserting) {
      context.missing(_quantiteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Spice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Spice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pieceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}piece_id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      quantite: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantite'],
      )!,
    );
  }

  @override
  $SpicesTable createAlias(String alias) {
    return $SpicesTable(attachedDatabase, alias);
  }
}

class Spice extends DataClass implements Insertable<Spice> {
  final int id;

  /// Référence à la pièce concernée.
  final int pieceId;

  /// Nom de l'épice (ex: "Poivre noir").
  final String nom;

  /// Quantité pesée en grammes.
  final double quantite;
  const Spice({
    required this.id,
    required this.pieceId,
    required this.nom,
    required this.quantite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['piece_id'] = Variable<int>(pieceId);
    map['nom'] = Variable<String>(nom);
    map['quantite'] = Variable<double>(quantite);
    return map;
  }

  SpicesCompanion toCompanion(bool nullToAbsent) {
    return SpicesCompanion(
      id: Value(id),
      pieceId: Value(pieceId),
      nom: Value(nom),
      quantite: Value(quantite),
    );
  }

  factory Spice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Spice(
      id: serializer.fromJson<int>(json['id']),
      pieceId: serializer.fromJson<int>(json['pieceId']),
      nom: serializer.fromJson<String>(json['nom']),
      quantite: serializer.fromJson<double>(json['quantite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pieceId': serializer.toJson<int>(pieceId),
      'nom': serializer.toJson<String>(nom),
      'quantite': serializer.toJson<double>(quantite),
    };
  }

  Spice copyWith({int? id, int? pieceId, String? nom, double? quantite}) =>
      Spice(
        id: id ?? this.id,
        pieceId: pieceId ?? this.pieceId,
        nom: nom ?? this.nom,
        quantite: quantite ?? this.quantite,
      );
  Spice copyWithCompanion(SpicesCompanion data) {
    return Spice(
      id: data.id.present ? data.id.value : this.id,
      pieceId: data.pieceId.present ? data.pieceId.value : this.pieceId,
      nom: data.nom.present ? data.nom.value : this.nom,
      quantite: data.quantite.present ? data.quantite.value : this.quantite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Spice(')
          ..write('id: $id, ')
          ..write('pieceId: $pieceId, ')
          ..write('nom: $nom, ')
          ..write('quantite: $quantite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pieceId, nom, quantite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Spice &&
          other.id == this.id &&
          other.pieceId == this.pieceId &&
          other.nom == this.nom &&
          other.quantite == this.quantite);
}

class SpicesCompanion extends UpdateCompanion<Spice> {
  final Value<int> id;
  final Value<int> pieceId;
  final Value<String> nom;
  final Value<double> quantite;
  const SpicesCompanion({
    this.id = const Value.absent(),
    this.pieceId = const Value.absent(),
    this.nom = const Value.absent(),
    this.quantite = const Value.absent(),
  });
  SpicesCompanion.insert({
    this.id = const Value.absent(),
    required int pieceId,
    required String nom,
    required double quantite,
  }) : pieceId = Value(pieceId),
       nom = Value(nom),
       quantite = Value(quantite);
  static Insertable<Spice> custom({
    Expression<int>? id,
    Expression<int>? pieceId,
    Expression<String>? nom,
    Expression<double>? quantite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pieceId != null) 'piece_id': pieceId,
      if (nom != null) 'nom': nom,
      if (quantite != null) 'quantite': quantite,
    });
  }

  SpicesCompanion copyWith({
    Value<int>? id,
    Value<int>? pieceId,
    Value<String>? nom,
    Value<double>? quantite,
  }) {
    return SpicesCompanion(
      id: id ?? this.id,
      pieceId: pieceId ?? this.pieceId,
      nom: nom ?? this.nom,
      quantite: quantite ?? this.quantite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pieceId.present) {
      map['piece_id'] = Variable<int>(pieceId.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (quantite.present) {
      map['quantite'] = Variable<double>(quantite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpicesCompanion(')
          ..write('id: $id, ')
          ..write('pieceId: $pieceId, ')
          ..write('nom: $nom, ')
          ..write('quantite: $quantite')
          ..write(')'))
        .toString();
  }
}

class $MqttSettingsTable extends MqttSettings
    with TableInfo<$MqttSettingsTable, MqttSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MqttSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _brokerIpMeta = const VerificationMeta(
    'brokerIp',
  );
  @override
  late final GeneratedColumn<String> brokerIp = GeneratedColumn<String>(
    'broker_ip',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _portMeta = const VerificationMeta('port');
  @override
  late final GeneratedColumn<int> port = GeneratedColumn<int>(
    'port',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1883),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _topicRootMeta = const VerificationMeta(
    'topicRoot',
  );
  @override
  late final GeneratedColumn<String> topicRoot = GeneratedColumn<String>(
    'topic_root',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('salaison'),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    brokerIp,
    port,
    username,
    password,
    topicRoot,
    isEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mqtt_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<MqttSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('broker_ip')) {
      context.handle(
        _brokerIpMeta,
        brokerIp.isAcceptableOrUnknown(data['broker_ip']!, _brokerIpMeta),
      );
    }
    if (data.containsKey('port')) {
      context.handle(
        _portMeta,
        port.isAcceptableOrUnknown(data['port']!, _portMeta),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    }
    if (data.containsKey('topic_root')) {
      context.handle(
        _topicRootMeta,
        topicRoot.isAcceptableOrUnknown(data['topic_root']!, _topicRootMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MqttSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MqttSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      brokerIp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}broker_ip'],
      )!,
      port: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}port'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      topicRoot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_root'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
    );
  }

  @override
  $MqttSettingsTable createAlias(String alias) {
    return $MqttSettingsTable(attachedDatabase, alias);
  }
}

class MqttSetting extends DataClass implements Insertable<MqttSetting> {
  final int id;
  final String brokerIp;
  final int port;
  final String username;
  final String password;
  final String topicRoot;
  final bool isEnabled;
  const MqttSetting({
    required this.id,
    required this.brokerIp,
    required this.port,
    required this.username,
    required this.password,
    required this.topicRoot,
    required this.isEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['broker_ip'] = Variable<String>(brokerIp);
    map['port'] = Variable<int>(port);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['topic_root'] = Variable<String>(topicRoot);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  MqttSettingsCompanion toCompanion(bool nullToAbsent) {
    return MqttSettingsCompanion(
      id: Value(id),
      brokerIp: Value(brokerIp),
      port: Value(port),
      username: Value(username),
      password: Value(password),
      topicRoot: Value(topicRoot),
      isEnabled: Value(isEnabled),
    );
  }

  factory MqttSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MqttSetting(
      id: serializer.fromJson<int>(json['id']),
      brokerIp: serializer.fromJson<String>(json['brokerIp']),
      port: serializer.fromJson<int>(json['port']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      topicRoot: serializer.fromJson<String>(json['topicRoot']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brokerIp': serializer.toJson<String>(brokerIp),
      'port': serializer.toJson<int>(port),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'topicRoot': serializer.toJson<String>(topicRoot),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  MqttSetting copyWith({
    int? id,
    String? brokerIp,
    int? port,
    String? username,
    String? password,
    String? topicRoot,
    bool? isEnabled,
  }) => MqttSetting(
    id: id ?? this.id,
    brokerIp: brokerIp ?? this.brokerIp,
    port: port ?? this.port,
    username: username ?? this.username,
    password: password ?? this.password,
    topicRoot: topicRoot ?? this.topicRoot,
    isEnabled: isEnabled ?? this.isEnabled,
  );
  MqttSetting copyWithCompanion(MqttSettingsCompanion data) {
    return MqttSetting(
      id: data.id.present ? data.id.value : this.id,
      brokerIp: data.brokerIp.present ? data.brokerIp.value : this.brokerIp,
      port: data.port.present ? data.port.value : this.port,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      topicRoot: data.topicRoot.present ? data.topicRoot.value : this.topicRoot,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MqttSetting(')
          ..write('id: $id, ')
          ..write('brokerIp: $brokerIp, ')
          ..write('port: $port, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('topicRoot: $topicRoot, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, brokerIp, port, username, password, topicRoot, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MqttSetting &&
          other.id == this.id &&
          other.brokerIp == this.brokerIp &&
          other.port == this.port &&
          other.username == this.username &&
          other.password == this.password &&
          other.topicRoot == this.topicRoot &&
          other.isEnabled == this.isEnabled);
}

class MqttSettingsCompanion extends UpdateCompanion<MqttSetting> {
  final Value<int> id;
  final Value<String> brokerIp;
  final Value<int> port;
  final Value<String> username;
  final Value<String> password;
  final Value<String> topicRoot;
  final Value<bool> isEnabled;
  const MqttSettingsCompanion({
    this.id = const Value.absent(),
    this.brokerIp = const Value.absent(),
    this.port = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.topicRoot = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  MqttSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.brokerIp = const Value.absent(),
    this.port = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.topicRoot = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  static Insertable<MqttSetting> custom({
    Expression<int>? id,
    Expression<String>? brokerIp,
    Expression<int>? port,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? topicRoot,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brokerIp != null) 'broker_ip': brokerIp,
      if (port != null) 'port': port,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (topicRoot != null) 'topic_root': topicRoot,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  MqttSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? brokerIp,
    Value<int>? port,
    Value<String>? username,
    Value<String>? password,
    Value<String>? topicRoot,
    Value<bool>? isEnabled,
  }) {
    return MqttSettingsCompanion(
      id: id ?? this.id,
      brokerIp: brokerIp ?? this.brokerIp,
      port: port ?? this.port,
      username: username ?? this.username,
      password: password ?? this.password,
      topicRoot: topicRoot ?? this.topicRoot,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brokerIp.present) {
      map['broker_ip'] = Variable<String>(brokerIp.value);
    }
    if (port.present) {
      map['port'] = Variable<int>(port.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (topicRoot.present) {
      map['topic_root'] = Variable<String>(topicRoot.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MqttSettingsCompanion(')
          ..write('id: $id, ')
          ..write('brokerIp: $brokerIp, ')
          ..write('port: $port, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('topicRoot: $topicRoot, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductTypesTable productTypes = $ProductTypesTable(this);
  late final $PiecesTable pieces = $PiecesTable(this);
  late final $WeighingsTable weighings = $WeighingsTable(this);
  late final $SpicesTable spices = $SpicesTable(this);
  late final $MqttSettingsTable mqttSettings = $MqttSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    productTypes,
    pieces,
    weighings,
    spices,
    mqttSettings,
  ];
}

typedef $$ProductTypesTableCreateCompanionBuilder =
    ProductTypesCompanion Function({
      Value<int> id,
      required String label,
      Value<String?> iconCategory,
    });
typedef $$ProductTypesTableUpdateCompanionBuilder =
    ProductTypesCompanion Function({
      Value<int> id,
      Value<String> label,
      Value<String?> iconCategory,
    });

final class $$ProductTypesTableReferences
    extends BaseReferences<_$AppDatabase, $ProductTypesTable, ProductType> {
  $$ProductTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PiecesTable, List<Piece>> _piecesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.pieces,
    aliasName: $_aliasNameGenerator(
      db.productTypes.id,
      db.pieces.productTypeId,
    ),
  );

  $$PiecesTableProcessedTableManager get piecesRefs {
    final manager = $$PiecesTableTableManager(
      $_db,
      $_db.pieces,
    ).filter((f) => f.productTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_piecesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductTypesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductTypesTable> {
  $$ProductTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconCategory => $composableBuilder(
    column: $table.iconCategory,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> piecesRefs(
    Expression<bool> Function($$PiecesTableFilterComposer f) f,
  ) {
    final $$PiecesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pieces,
      getReferencedColumn: (t) => t.productTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PiecesTableFilterComposer(
            $db: $db,
            $table: $db.pieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductTypesTable> {
  $$ProductTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconCategory => $composableBuilder(
    column: $table.iconCategory,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductTypesTable> {
  $$ProductTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get iconCategory => $composableBuilder(
    column: $table.iconCategory,
    builder: (column) => column,
  );

  Expression<T> piecesRefs<T extends Object>(
    Expression<T> Function($$PiecesTableAnnotationComposer a) f,
  ) {
    final $$PiecesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pieces,
      getReferencedColumn: (t) => t.productTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PiecesTableAnnotationComposer(
            $db: $db,
            $table: $db.pieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductTypesTable,
          ProductType,
          $$ProductTypesTableFilterComposer,
          $$ProductTypesTableOrderingComposer,
          $$ProductTypesTableAnnotationComposer,
          $$ProductTypesTableCreateCompanionBuilder,
          $$ProductTypesTableUpdateCompanionBuilder,
          (ProductType, $$ProductTypesTableReferences),
          ProductType,
          PrefetchHooks Function({bool piecesRefs})
        > {
  $$ProductTypesTableTableManager(_$AppDatabase db, $ProductTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> iconCategory = const Value.absent(),
              }) => ProductTypesCompanion(
                id: id,
                label: label,
                iconCategory: iconCategory,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String label,
                Value<String?> iconCategory = const Value.absent(),
              }) => ProductTypesCompanion.insert(
                id: id,
                label: label,
                iconCategory: iconCategory,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({piecesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (piecesRefs) db.pieces],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (piecesRefs)
                    await $_getPrefetchedData<
                      ProductType,
                      $ProductTypesTable,
                      Piece
                    >(
                      currentTable: table,
                      referencedTable: $$ProductTypesTableReferences
                          ._piecesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProductTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).piecesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.productTypeId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductTypesTable,
      ProductType,
      $$ProductTypesTableFilterComposer,
      $$ProductTypesTableOrderingComposer,
      $$ProductTypesTableAnnotationComposer,
      $$ProductTypesTableCreateCompanionBuilder,
      $$ProductTypesTableUpdateCompanionBuilder,
      (ProductType, $$ProductTypesTableReferences),
      ProductType,
      PrefetchHooks Function({bool piecesRefs})
    >;
typedef $$PiecesTableCreateCompanionBuilder =
    PiecesCompanion Function({
      Value<int> id,
      required String nom,
      required double poidsInitial,
      required double poidsCible,
      required double quantiteSel,
      required double quantiteSucre,
      required DateTime dateDebut,
      Value<String> statut,
      Value<String?> notes,
      Value<String?> imagePath,
      Value<int> minSalaisonDays,
      Value<String?> woodBlend,
      Value<double?> preDryingWeight,
      Value<bool> isArchived,
      Value<double> smokingDuration,
      Value<int?> productTypeId,
      Value<String?> physicalID,
    });
typedef $$PiecesTableUpdateCompanionBuilder =
    PiecesCompanion Function({
      Value<int> id,
      Value<String> nom,
      Value<double> poidsInitial,
      Value<double> poidsCible,
      Value<double> quantiteSel,
      Value<double> quantiteSucre,
      Value<DateTime> dateDebut,
      Value<String> statut,
      Value<String?> notes,
      Value<String?> imagePath,
      Value<int> minSalaisonDays,
      Value<String?> woodBlend,
      Value<double?> preDryingWeight,
      Value<bool> isArchived,
      Value<double> smokingDuration,
      Value<int?> productTypeId,
      Value<String?> physicalID,
    });

final class $$PiecesTableReferences
    extends BaseReferences<_$AppDatabase, $PiecesTable, Piece> {
  $$PiecesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductTypesTable _productTypeIdTable(_$AppDatabase db) =>
      db.productTypes.createAlias(
        $_aliasNameGenerator(db.pieces.productTypeId, db.productTypes.id),
      );

  $$ProductTypesTableProcessedTableManager? get productTypeId {
    final $_column = $_itemColumn<int>('product_type_id');
    if ($_column == null) return null;
    final manager = $$ProductTypesTableTableManager(
      $_db,
      $_db.productTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WeighingsTable, List<Weighing>>
  _weighingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weighings,
    aliasName: $_aliasNameGenerator(db.pieces.id, db.weighings.pieceId),
  );

  $$WeighingsTableProcessedTableManager get weighingsRefs {
    final manager = $$WeighingsTableTableManager(
      $_db,
      $_db.weighings,
    ).filter((f) => f.pieceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_weighingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SpicesTable, List<Spice>> _spicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.spices,
    aliasName: $_aliasNameGenerator(db.pieces.id, db.spices.pieceId),
  );

  $$SpicesTableProcessedTableManager get spicesRefs {
    final manager = $$SpicesTableTableManager(
      $_db,
      $_db.spices,
    ).filter((f) => f.pieceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_spicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PiecesTableFilterComposer
    extends Composer<_$AppDatabase, $PiecesTable> {
  $$PiecesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get poidsInitial => $composableBuilder(
    column: $table.poidsInitial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get poidsCible => $composableBuilder(
    column: $table.poidsCible,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantiteSel => $composableBuilder(
    column: $table.quantiteSel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantiteSucre => $composableBuilder(
    column: $table.quantiteSucre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateDebut => $composableBuilder(
    column: $table.dateDebut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minSalaisonDays => $composableBuilder(
    column: $table.minSalaisonDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get woodBlend => $composableBuilder(
    column: $table.woodBlend,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get preDryingWeight => $composableBuilder(
    column: $table.preDryingWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get smokingDuration => $composableBuilder(
    column: $table.smokingDuration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get physicalID => $composableBuilder(
    column: $table.physicalID,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductTypesTableFilterComposer get productTypeId {
    final $$ProductTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productTypeId,
      referencedTable: $db.productTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTypesTableFilterComposer(
            $db: $db,
            $table: $db.productTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> weighingsRefs(
    Expression<bool> Function($$WeighingsTableFilterComposer f) f,
  ) {
    final $$WeighingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weighings,
      getReferencedColumn: (t) => t.pieceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeighingsTableFilterComposer(
            $db: $db,
            $table: $db.weighings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> spicesRefs(
    Expression<bool> Function($$SpicesTableFilterComposer f) f,
  ) {
    final $$SpicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.spices,
      getReferencedColumn: (t) => t.pieceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpicesTableFilterComposer(
            $db: $db,
            $table: $db.spices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PiecesTableOrderingComposer
    extends Composer<_$AppDatabase, $PiecesTable> {
  $$PiecesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get poidsInitial => $composableBuilder(
    column: $table.poidsInitial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get poidsCible => $composableBuilder(
    column: $table.poidsCible,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantiteSel => $composableBuilder(
    column: $table.quantiteSel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantiteSucre => $composableBuilder(
    column: $table.quantiteSucre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateDebut => $composableBuilder(
    column: $table.dateDebut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minSalaisonDays => $composableBuilder(
    column: $table.minSalaisonDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get woodBlend => $composableBuilder(
    column: $table.woodBlend,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get preDryingWeight => $composableBuilder(
    column: $table.preDryingWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get smokingDuration => $composableBuilder(
    column: $table.smokingDuration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get physicalID => $composableBuilder(
    column: $table.physicalID,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductTypesTableOrderingComposer get productTypeId {
    final $$ProductTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productTypeId,
      referencedTable: $db.productTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTypesTableOrderingComposer(
            $db: $db,
            $table: $db.productTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PiecesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PiecesTable> {
  $$PiecesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<double> get poidsInitial => $composableBuilder(
    column: $table.poidsInitial,
    builder: (column) => column,
  );

  GeneratedColumn<double> get poidsCible => $composableBuilder(
    column: $table.poidsCible,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantiteSel => $composableBuilder(
    column: $table.quantiteSel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantiteSucre => $composableBuilder(
    column: $table.quantiteSucre,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateDebut =>
      $composableBuilder(column: $table.dateDebut, builder: (column) => column);

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get minSalaisonDays => $composableBuilder(
    column: $table.minSalaisonDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get woodBlend =>
      $composableBuilder(column: $table.woodBlend, builder: (column) => column);

  GeneratedColumn<double> get preDryingWeight => $composableBuilder(
    column: $table.preDryingWeight,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<double> get smokingDuration => $composableBuilder(
    column: $table.smokingDuration,
    builder: (column) => column,
  );

  GeneratedColumn<String> get physicalID => $composableBuilder(
    column: $table.physicalID,
    builder: (column) => column,
  );

  $$ProductTypesTableAnnotationComposer get productTypeId {
    final $$ProductTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productTypeId,
      referencedTable: $db.productTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.productTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> weighingsRefs<T extends Object>(
    Expression<T> Function($$WeighingsTableAnnotationComposer a) f,
  ) {
    final $$WeighingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weighings,
      getReferencedColumn: (t) => t.pieceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeighingsTableAnnotationComposer(
            $db: $db,
            $table: $db.weighings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> spicesRefs<T extends Object>(
    Expression<T> Function($$SpicesTableAnnotationComposer a) f,
  ) {
    final $$SpicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.spices,
      getReferencedColumn: (t) => t.pieceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpicesTableAnnotationComposer(
            $db: $db,
            $table: $db.spices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PiecesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PiecesTable,
          Piece,
          $$PiecesTableFilterComposer,
          $$PiecesTableOrderingComposer,
          $$PiecesTableAnnotationComposer,
          $$PiecesTableCreateCompanionBuilder,
          $$PiecesTableUpdateCompanionBuilder,
          (Piece, $$PiecesTableReferences),
          Piece,
          PrefetchHooks Function({
            bool productTypeId,
            bool weighingsRefs,
            bool spicesRefs,
          })
        > {
  $$PiecesTableTableManager(_$AppDatabase db, $PiecesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PiecesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PiecesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PiecesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<double> poidsInitial = const Value.absent(),
                Value<double> poidsCible = const Value.absent(),
                Value<double> quantiteSel = const Value.absent(),
                Value<double> quantiteSucre = const Value.absent(),
                Value<DateTime> dateDebut = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<int> minSalaisonDays = const Value.absent(),
                Value<String?> woodBlend = const Value.absent(),
                Value<double?> preDryingWeight = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<double> smokingDuration = const Value.absent(),
                Value<int?> productTypeId = const Value.absent(),
                Value<String?> physicalID = const Value.absent(),
              }) => PiecesCompanion(
                id: id,
                nom: nom,
                poidsInitial: poidsInitial,
                poidsCible: poidsCible,
                quantiteSel: quantiteSel,
                quantiteSucre: quantiteSucre,
                dateDebut: dateDebut,
                statut: statut,
                notes: notes,
                imagePath: imagePath,
                minSalaisonDays: minSalaisonDays,
                woodBlend: woodBlend,
                preDryingWeight: preDryingWeight,
                isArchived: isArchived,
                smokingDuration: smokingDuration,
                productTypeId: productTypeId,
                physicalID: physicalID,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nom,
                required double poidsInitial,
                required double poidsCible,
                required double quantiteSel,
                required double quantiteSucre,
                required DateTime dateDebut,
                Value<String> statut = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<int> minSalaisonDays = const Value.absent(),
                Value<String?> woodBlend = const Value.absent(),
                Value<double?> preDryingWeight = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<double> smokingDuration = const Value.absent(),
                Value<int?> productTypeId = const Value.absent(),
                Value<String?> physicalID = const Value.absent(),
              }) => PiecesCompanion.insert(
                id: id,
                nom: nom,
                poidsInitial: poidsInitial,
                poidsCible: poidsCible,
                quantiteSel: quantiteSel,
                quantiteSucre: quantiteSucre,
                dateDebut: dateDebut,
                statut: statut,
                notes: notes,
                imagePath: imagePath,
                minSalaisonDays: minSalaisonDays,
                woodBlend: woodBlend,
                preDryingWeight: preDryingWeight,
                isArchived: isArchived,
                smokingDuration: smokingDuration,
                productTypeId: productTypeId,
                physicalID: physicalID,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PiecesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                productTypeId = false,
                weighingsRefs = false,
                spicesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (weighingsRefs) db.weighings,
                    if (spicesRefs) db.spices,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (productTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productTypeId,
                                    referencedTable: $$PiecesTableReferences
                                        ._productTypeIdTable(db),
                                    referencedColumn: $$PiecesTableReferences
                                        ._productTypeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (weighingsRefs)
                        await $_getPrefetchedData<
                          Piece,
                          $PiecesTable,
                          Weighing
                        >(
                          currentTable: table,
                          referencedTable: $$PiecesTableReferences
                              ._weighingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PiecesTableReferences(
                                db,
                                table,
                                p0,
                              ).weighingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pieceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (spicesRefs)
                        await $_getPrefetchedData<Piece, $PiecesTable, Spice>(
                          currentTable: table,
                          referencedTable: $$PiecesTableReferences
                              ._spicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PiecesTableReferences(db, table, p0).spicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pieceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PiecesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PiecesTable,
      Piece,
      $$PiecesTableFilterComposer,
      $$PiecesTableOrderingComposer,
      $$PiecesTableAnnotationComposer,
      $$PiecesTableCreateCompanionBuilder,
      $$PiecesTableUpdateCompanionBuilder,
      (Piece, $$PiecesTableReferences),
      Piece,
      PrefetchHooks Function({
        bool productTypeId,
        bool weighingsRefs,
        bool spicesRefs,
      })
    >;
typedef $$WeighingsTableCreateCompanionBuilder =
    WeighingsCompanion Function({
      Value<int> id,
      required int pieceId,
      required DateTime date,
      required double poids,
      Value<String?> label,
    });
typedef $$WeighingsTableUpdateCompanionBuilder =
    WeighingsCompanion Function({
      Value<int> id,
      Value<int> pieceId,
      Value<DateTime> date,
      Value<double> poids,
      Value<String?> label,
    });

final class $$WeighingsTableReferences
    extends BaseReferences<_$AppDatabase, $WeighingsTable, Weighing> {
  $$WeighingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PiecesTable _pieceIdTable(_$AppDatabase db) => db.pieces.createAlias(
    $_aliasNameGenerator(db.weighings.pieceId, db.pieces.id),
  );

  $$PiecesTableProcessedTableManager get pieceId {
    final $_column = $_itemColumn<int>('piece_id')!;

    final manager = $$PiecesTableTableManager(
      $_db,
      $_db.pieces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pieceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeighingsTableFilterComposer
    extends Composer<_$AppDatabase, $WeighingsTable> {
  $$WeighingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get poids => $composableBuilder(
    column: $table.poids,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  $$PiecesTableFilterComposer get pieceId {
    final $$PiecesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pieceId,
      referencedTable: $db.pieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PiecesTableFilterComposer(
            $db: $db,
            $table: $db.pieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeighingsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeighingsTable> {
  $$WeighingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get poids => $composableBuilder(
    column: $table.poids,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  $$PiecesTableOrderingComposer get pieceId {
    final $$PiecesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pieceId,
      referencedTable: $db.pieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PiecesTableOrderingComposer(
            $db: $db,
            $table: $db.pieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeighingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeighingsTable> {
  $$WeighingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get poids =>
      $composableBuilder(column: $table.poids, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  $$PiecesTableAnnotationComposer get pieceId {
    final $$PiecesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pieceId,
      referencedTable: $db.pieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PiecesTableAnnotationComposer(
            $db: $db,
            $table: $db.pieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeighingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeighingsTable,
          Weighing,
          $$WeighingsTableFilterComposer,
          $$WeighingsTableOrderingComposer,
          $$WeighingsTableAnnotationComposer,
          $$WeighingsTableCreateCompanionBuilder,
          $$WeighingsTableUpdateCompanionBuilder,
          (Weighing, $$WeighingsTableReferences),
          Weighing,
          PrefetchHooks Function({bool pieceId})
        > {
  $$WeighingsTableTableManager(_$AppDatabase db, $WeighingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeighingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeighingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeighingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> pieceId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> poids = const Value.absent(),
                Value<String?> label = const Value.absent(),
              }) => WeighingsCompanion(
                id: id,
                pieceId: pieceId,
                date: date,
                poids: poids,
                label: label,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int pieceId,
                required DateTime date,
                required double poids,
                Value<String?> label = const Value.absent(),
              }) => WeighingsCompanion.insert(
                id: id,
                pieceId: pieceId,
                date: date,
                poids: poids,
                label: label,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeighingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pieceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pieceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pieceId,
                                referencedTable: $$WeighingsTableReferences
                                    ._pieceIdTable(db),
                                referencedColumn: $$WeighingsTableReferences
                                    ._pieceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeighingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeighingsTable,
      Weighing,
      $$WeighingsTableFilterComposer,
      $$WeighingsTableOrderingComposer,
      $$WeighingsTableAnnotationComposer,
      $$WeighingsTableCreateCompanionBuilder,
      $$WeighingsTableUpdateCompanionBuilder,
      (Weighing, $$WeighingsTableReferences),
      Weighing,
      PrefetchHooks Function({bool pieceId})
    >;
typedef $$SpicesTableCreateCompanionBuilder =
    SpicesCompanion Function({
      Value<int> id,
      required int pieceId,
      required String nom,
      required double quantite,
    });
typedef $$SpicesTableUpdateCompanionBuilder =
    SpicesCompanion Function({
      Value<int> id,
      Value<int> pieceId,
      Value<String> nom,
      Value<double> quantite,
    });

final class $$SpicesTableReferences
    extends BaseReferences<_$AppDatabase, $SpicesTable, Spice> {
  $$SpicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PiecesTable _pieceIdTable(_$AppDatabase db) => db.pieces.createAlias(
    $_aliasNameGenerator(db.spices.pieceId, db.pieces.id),
  );

  $$PiecesTableProcessedTableManager get pieceId {
    final $_column = $_itemColumn<int>('piece_id')!;

    final manager = $$PiecesTableTableManager(
      $_db,
      $_db.pieces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pieceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SpicesTableFilterComposer
    extends Composer<_$AppDatabase, $SpicesTable> {
  $$SpicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantite => $composableBuilder(
    column: $table.quantite,
    builder: (column) => ColumnFilters(column),
  );

  $$PiecesTableFilterComposer get pieceId {
    final $$PiecesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pieceId,
      referencedTable: $db.pieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PiecesTableFilterComposer(
            $db: $db,
            $table: $db.pieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpicesTableOrderingComposer
    extends Composer<_$AppDatabase, $SpicesTable> {
  $$SpicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantite => $composableBuilder(
    column: $table.quantite,
    builder: (column) => ColumnOrderings(column),
  );

  $$PiecesTableOrderingComposer get pieceId {
    final $$PiecesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pieceId,
      referencedTable: $db.pieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PiecesTableOrderingComposer(
            $db: $db,
            $table: $db.pieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpicesTable> {
  $$SpicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<double> get quantite =>
      $composableBuilder(column: $table.quantite, builder: (column) => column);

  $$PiecesTableAnnotationComposer get pieceId {
    final $$PiecesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pieceId,
      referencedTable: $db.pieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PiecesTableAnnotationComposer(
            $db: $db,
            $table: $db.pieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpicesTable,
          Spice,
          $$SpicesTableFilterComposer,
          $$SpicesTableOrderingComposer,
          $$SpicesTableAnnotationComposer,
          $$SpicesTableCreateCompanionBuilder,
          $$SpicesTableUpdateCompanionBuilder,
          (Spice, $$SpicesTableReferences),
          Spice,
          PrefetchHooks Function({bool pieceId})
        > {
  $$SpicesTableTableManager(_$AppDatabase db, $SpicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> pieceId = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<double> quantite = const Value.absent(),
              }) => SpicesCompanion(
                id: id,
                pieceId: pieceId,
                nom: nom,
                quantite: quantite,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int pieceId,
                required String nom,
                required double quantite,
              }) => SpicesCompanion.insert(
                id: id,
                pieceId: pieceId,
                nom: nom,
                quantite: quantite,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SpicesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({pieceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pieceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pieceId,
                                referencedTable: $$SpicesTableReferences
                                    ._pieceIdTable(db),
                                referencedColumn: $$SpicesTableReferences
                                    ._pieceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SpicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpicesTable,
      Spice,
      $$SpicesTableFilterComposer,
      $$SpicesTableOrderingComposer,
      $$SpicesTableAnnotationComposer,
      $$SpicesTableCreateCompanionBuilder,
      $$SpicesTableUpdateCompanionBuilder,
      (Spice, $$SpicesTableReferences),
      Spice,
      PrefetchHooks Function({bool pieceId})
    >;
typedef $$MqttSettingsTableCreateCompanionBuilder =
    MqttSettingsCompanion Function({
      Value<int> id,
      Value<String> brokerIp,
      Value<int> port,
      Value<String> username,
      Value<String> password,
      Value<String> topicRoot,
      Value<bool> isEnabled,
    });
typedef $$MqttSettingsTableUpdateCompanionBuilder =
    MqttSettingsCompanion Function({
      Value<int> id,
      Value<String> brokerIp,
      Value<int> port,
      Value<String> username,
      Value<String> password,
      Value<String> topicRoot,
      Value<bool> isEnabled,
    });

class $$MqttSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $MqttSettingsTable> {
  $$MqttSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brokerIp => $composableBuilder(
    column: $table.brokerIp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get port => $composableBuilder(
    column: $table.port,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicRoot => $composableBuilder(
    column: $table.topicRoot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MqttSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $MqttSettingsTable> {
  $$MqttSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brokerIp => $composableBuilder(
    column: $table.brokerIp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get port => $composableBuilder(
    column: $table.port,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicRoot => $composableBuilder(
    column: $table.topicRoot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MqttSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MqttSettingsTable> {
  $$MqttSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get brokerIp =>
      $composableBuilder(column: $table.brokerIp, builder: (column) => column);

  GeneratedColumn<int> get port =>
      $composableBuilder(column: $table.port, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get topicRoot =>
      $composableBuilder(column: $table.topicRoot, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);
}

class $$MqttSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MqttSettingsTable,
          MqttSetting,
          $$MqttSettingsTableFilterComposer,
          $$MqttSettingsTableOrderingComposer,
          $$MqttSettingsTableAnnotationComposer,
          $$MqttSettingsTableCreateCompanionBuilder,
          $$MqttSettingsTableUpdateCompanionBuilder,
          (
            MqttSetting,
            BaseReferences<_$AppDatabase, $MqttSettingsTable, MqttSetting>,
          ),
          MqttSetting,
          PrefetchHooks Function()
        > {
  $$MqttSettingsTableTableManager(_$AppDatabase db, $MqttSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MqttSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MqttSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MqttSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> brokerIp = const Value.absent(),
                Value<int> port = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> topicRoot = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
              }) => MqttSettingsCompanion(
                id: id,
                brokerIp: brokerIp,
                port: port,
                username: username,
                password: password,
                topicRoot: topicRoot,
                isEnabled: isEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> brokerIp = const Value.absent(),
                Value<int> port = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> topicRoot = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
              }) => MqttSettingsCompanion.insert(
                id: id,
                brokerIp: brokerIp,
                port: port,
                username: username,
                password: password,
                topicRoot: topicRoot,
                isEnabled: isEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MqttSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MqttSettingsTable,
      MqttSetting,
      $$MqttSettingsTableFilterComposer,
      $$MqttSettingsTableOrderingComposer,
      $$MqttSettingsTableAnnotationComposer,
      $$MqttSettingsTableCreateCompanionBuilder,
      $$MqttSettingsTableUpdateCompanionBuilder,
      (
        MqttSetting,
        BaseReferences<_$AppDatabase, $MqttSettingsTable, MqttSetting>,
      ),
      MqttSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductTypesTableTableManager get productTypes =>
      $$ProductTypesTableTableManager(_db, _db.productTypes);
  $$PiecesTableTableManager get pieces =>
      $$PiecesTableTableManager(_db, _db.pieces);
  $$WeighingsTableTableManager get weighings =>
      $$WeighingsTableTableManager(_db, _db.weighings);
  $$SpicesTableTableManager get spices =>
      $$SpicesTableTableManager(_db, _db.spices);
  $$MqttSettingsTableTableManager get mqttSettings =>
      $$MqttSettingsTableTableManager(_db, _db.mqttSettings);
}
