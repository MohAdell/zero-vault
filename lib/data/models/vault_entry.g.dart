// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVaultEntryCollection on Isar {
  IsarCollection<VaultEntry> get vaultEntrys => this.collection();
}

const VaultEntrySchema = CollectionSchema(
  name: r'VaultEntry',
  id: 2380021720914536,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'encCategory': PropertySchema(
      id: 1,
      name: r'encCategory',
      type: IsarType.string,
    ),
    r'encNotes': PropertySchema(
      id: 2,
      name: r'encNotes',
      type: IsarType.string,
    ),
    r'encPassword': PropertySchema(
      id: 3,
      name: r'encPassword',
      type: IsarType.string,
    ),
    r'encTitle': PropertySchema(
      id: 4,
      name: r'encTitle',
      type: IsarType.string,
    ),
    r'encTotpSecret': PropertySchema(
      id: 5,
      name: r'encTotpSecret',
      type: IsarType.string,
    ),
    r'encUrl': PropertySchema(id: 6, name: r'encUrl', type: IsarType.string),
    r'encUsername': PropertySchema(
      id: 7,
      name: r'encUsername',
      type: IsarType.string,
    ),
    r'isFavorite': PropertySchema(
      id: 8,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(id: 10, name: r'uuid', type: IsarType.string),
  },
  estimateSize: _vaultEntryEstimateSize,
  serialize: _vaultEntrySerialize,
  deserialize: _vaultEntryDeserialize,
  deserializeProp: _vaultEntryDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724,
      name: r'uuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _vaultEntryGetId,
  getLinks: _vaultEntryGetLinks,
  attach: _vaultEntryAttach,
  version: '3.1.0+1',
);

int _vaultEntryEstimateSize(
  VaultEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.encCategory;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.encNotes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.encPassword.length * 3;
  bytesCount += 3 + object.encTitle.length * 3;
  {
    final value = object.encTotpSecret;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.encUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.encUsername.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _vaultEntrySerialize(
  VaultEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.encCategory);
  writer.writeString(offsets[2], object.encNotes);
  writer.writeString(offsets[3], object.encPassword);
  writer.writeString(offsets[4], object.encTitle);
  writer.writeString(offsets[5], object.encTotpSecret);
  writer.writeString(offsets[6], object.encUrl);
  writer.writeString(offsets[7], object.encUsername);
  writer.writeBool(offsets[8], object.isFavorite);
  writer.writeDateTime(offsets[9], object.updatedAt);
  writer.writeString(offsets[10], object.uuid);
}

VaultEntry _vaultEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VaultEntry(
    createdAt: reader.readDateTime(offsets[0]),
    encCategory: reader.readStringOrNull(offsets[1]),
    encNotes: reader.readStringOrNull(offsets[2]),
    encPassword: reader.readString(offsets[3]),
    encTitle: reader.readString(offsets[4]),
    encTotpSecret: reader.readStringOrNull(offsets[5]),
    encUrl: reader.readStringOrNull(offsets[6]),
    encUsername: reader.readString(offsets[7]),
    id: id,
    isFavorite: reader.readBoolOrNull(offsets[8]) ?? false,
    updatedAt: reader.readDateTime(offsets[9]),
    uuid: reader.readString(offsets[10]),
  );
  return object;
}

P _vaultEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vaultEntryGetId(VaultEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vaultEntryGetLinks(VaultEntry object) {
  return [];
}

void _vaultEntryAttach(IsarCollection<dynamic> col, Id id, VaultEntry object) {
  object.id = id;
}

extension VaultEntryByIndex on IsarCollection<VaultEntry> {
  Future<VaultEntry?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  VaultEntry? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<VaultEntry?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<VaultEntry?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(VaultEntry object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(VaultEntry object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<VaultEntry> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<VaultEntry> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension VaultEntryQueryWhereSort
    on QueryBuilder<VaultEntry, VaultEntry, QWhere> {
  QueryBuilder<VaultEntry, VaultEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VaultEntryQueryWhere
    on QueryBuilder<VaultEntry, VaultEntry, QWhereClause> {
  QueryBuilder<VaultEntry, VaultEntry, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterWhereClause> uuidEqualTo(
    String uuid,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uuid', value: [uuid]),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterWhereClause> uuidNotEqualTo(
    String uuid,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [],
                upper: [uuid],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [uuid],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [uuid],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [],
                upper: [uuid],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension VaultEntryQueryFilter
    on QueryBuilder<VaultEntry, VaultEntry, QFilterCondition> {
  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> createdAtEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'encCategory'),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'encCategory'),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'encCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'encCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'encCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'encCategory',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'encCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'encCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'encCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'encCategory',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'encCategory', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'encCategory', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encNotesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'encNotes'),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encNotesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'encNotes'),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encNotesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'encNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encNotesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'encNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encNotesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'encNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encNotesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'encNotes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encNotesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'encNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encNotesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'encNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encNotesContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'encNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encNotesMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'encNotes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'encNotes', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'encNotes', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encPasswordEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'encPassword',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encPasswordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'encPassword',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encPasswordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'encPassword',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encPasswordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'encPassword',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encPasswordStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'encPassword',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encPasswordEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'encPassword',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encPasswordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'encPassword',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encPasswordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'encPassword',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encPasswordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'encPassword', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encPasswordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'encPassword', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'encTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'encTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'encTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'encTitle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTitleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'encTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'encTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encTitleContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'encTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encTitleMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'encTitle',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'encTitle', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'encTitle', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'encTotpSecret'),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'encTotpSecret'),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'encTotpSecret',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'encTotpSecret',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'encTotpSecret',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'encTotpSecret',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'encTotpSecret',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'encTotpSecret',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'encTotpSecret',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'encTotpSecret',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'encTotpSecret', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encTotpSecretIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'encTotpSecret', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'encUrl'),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'encUrl'),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'encUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'encUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'encUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'encUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'encUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'encUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encUrlContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'encUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encUrlMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'encUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> encUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'encUrl', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'encUrl', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUsernameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'encUsername',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUsernameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'encUsername',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUsernameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'encUsername',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUsernameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'encUsername',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUsernameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'encUsername',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUsernameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'encUsername',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUsernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'encUsername',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUsernameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'encUsername',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUsernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'encUsername', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  encUsernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'encUsername', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> isFavoriteEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isFavorite', value: value),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> updatedAtEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uuid',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> uuidContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> uuidMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'uuid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uuid', value: ''),
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uuid', value: ''),
      );
    });
  }
}

extension VaultEntryQueryObject
    on QueryBuilder<VaultEntry, VaultEntry, QFilterCondition> {}

extension VaultEntryQueryLinks
    on QueryBuilder<VaultEntry, VaultEntry, QFilterCondition> {}

extension VaultEntryQuerySortBy
    on QueryBuilder<VaultEntry, VaultEntry, QSortBy> {
  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encCategory', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encCategory', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encNotes', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encNotes', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encPassword', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encPassword', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encTitle', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encTitle', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncTotpSecret() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encTotpSecret', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncTotpSecretDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encTotpSecret', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encUrl', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encUrl', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encUsername', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByEncUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encUsername', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension VaultEntryQuerySortThenBy
    on QueryBuilder<VaultEntry, VaultEntry, QSortThenBy> {
  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encCategory', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encCategory', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encNotes', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encNotes', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encPassword', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encPassword', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encTitle', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encTitle', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncTotpSecret() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encTotpSecret', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncTotpSecretDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encTotpSecret', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encUrl', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encUrl', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encUsername', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByEncUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encUsername', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension VaultEntryQueryWhereDistinct
    on QueryBuilder<VaultEntry, VaultEntry, QDistinct> {
  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByEncCategory({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'encCategory', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByEncNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'encNotes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByEncPassword({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'encPassword', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByEncTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'encTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByEncTotpSecret({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'encTotpSecret',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByEncUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'encUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByEncUsername({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'encUsername', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<VaultEntry, VaultEntry, QDistinct> distinctByUuid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension VaultEntryQueryProperty
    on QueryBuilder<VaultEntry, VaultEntry, QQueryProperty> {
  QueryBuilder<VaultEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VaultEntry, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<VaultEntry, String?, QQueryOperations> encCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encCategory');
    });
  }

  QueryBuilder<VaultEntry, String?, QQueryOperations> encNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encNotes');
    });
  }

  QueryBuilder<VaultEntry, String, QQueryOperations> encPasswordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encPassword');
    });
  }

  QueryBuilder<VaultEntry, String, QQueryOperations> encTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encTitle');
    });
  }

  QueryBuilder<VaultEntry, String?, QQueryOperations> encTotpSecretProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encTotpSecret');
    });
  }

  QueryBuilder<VaultEntry, String?, QQueryOperations> encUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encUrl');
    });
  }

  QueryBuilder<VaultEntry, String, QQueryOperations> encUsernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encUsername');
    });
  }

  QueryBuilder<VaultEntry, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<VaultEntry, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<VaultEntry, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
