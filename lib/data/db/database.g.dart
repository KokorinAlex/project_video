// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class FilmsTableData extends DataClass implements Insertable<FilmsTableData> {
  final int id;
  final String title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final String? description;
  FilmsTableData(
      {required this.id,
      required this.title,
      this.picture,
      this.voteAverage,
      this.releaseDate,
      this.description});
  factory FilmsTableData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FilmsTableData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      picture: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}picture']),
      voteAverage: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vote_average']),
      releaseDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || picture != null) {
      map['picture'] = Variable<String?>(picture);
    }
    if (!nullToAbsent || voteAverage != null) {
      map['vote_average'] = Variable<double?>(voteAverage);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String?>(releaseDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    return map;
  }

  FilmsTableCompanion toCompanion(bool nullToAbsent) {
    return FilmsTableCompanion(
      id: Value(id),
      title: Value(title),
      picture: picture == null && nullToAbsent
          ? const Value.absent()
          : Value(picture),
      voteAverage: voteAverage == null && nullToAbsent
          ? const Value.absent()
          : Value(voteAverage),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory FilmsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilmsTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      picture: serializer.fromJson<String?>(json['picture']),
      voteAverage: serializer.fromJson<double?>(json['voteAverage']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'picture': serializer.toJson<String?>(picture),
      'voteAverage': serializer.toJson<double?>(voteAverage),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'description': serializer.toJson<String?>(description),
    };
  }

  FilmsTableData copyWith(
          {int? id,
          String? title,
          String? picture,
          double? voteAverage,
          String? releaseDate,
          String? description}) =>
      FilmsTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        picture: picture ?? this.picture,
        voteAverage: voteAverage ?? this.voteAverage,
        releaseDate: releaseDate ?? this.releaseDate,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('FilmsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('picture: $picture, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, picture, voteAverage, releaseDate, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilmsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.picture == this.picture &&
          other.voteAverage == this.voteAverage &&
          other.releaseDate == this.releaseDate &&
          other.description == this.description);
}

class FilmsTableCompanion extends UpdateCompanion<FilmsTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> picture;
  final Value<double?> voteAverage;
  final Value<String?> releaseDate;
  final Value<String?> description;
  const FilmsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.picture = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.description = const Value.absent(),
  });
  FilmsTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.picture = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.description = const Value.absent(),
  }) : title = Value(title);
  static Insertable<FilmsTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String?>? picture,
    Expression<double?>? voteAverage,
    Expression<String?>? releaseDate,
    Expression<String?>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (picture != null) 'picture': picture,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (releaseDate != null) 'release_date': releaseDate,
      if (description != null) 'description': description,
    });
  }

  FilmsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? picture,
      Value<double?>? voteAverage,
      Value<String?>? releaseDate,
      Value<String?>? description}) {
    return FilmsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      picture: picture ?? this.picture,
      voteAverage: voteAverage ?? this.voteAverage,
      releaseDate: releaseDate ?? this.releaseDate,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (picture.present) {
      map['picture'] = Variable<String?>(picture.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double?>(voteAverage.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String?>(releaseDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilmsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('picture: $picture, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $FilmsTableTable extends FilmsTable
    with TableInfo<$FilmsTableTable, FilmsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilmsTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _pictureMeta = const VerificationMeta('picture');
  @override
  late final GeneratedColumn<String?> picture = GeneratedColumn<String?>(
      'picture', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double?> voteAverage = GeneratedColumn<double?>(
      'vote_average', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String?> releaseDate = GeneratedColumn<String?>(
      'release_date', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, picture, voteAverage, releaseDate, description];
  @override
  String get aliasedName => _alias ?? 'films_table';
  @override
  String get actualTableName => 'films_table';
  @override
  VerificationContext validateIntegrity(Insertable<FilmsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('picture')) {
      context.handle(_pictureMeta,
          picture.isAcceptableOrUnknown(data['picture']!, _pictureMeta));
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FilmsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FilmsTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FilmsTableTable createAlias(String alias) {
    return $FilmsTableTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $FilmsTableTable filmsTable = $FilmsTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [filmsTable];
}
