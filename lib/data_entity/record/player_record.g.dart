// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerRecord _$PlayerRecordFromJson(Map<String, dynamic> json) => PlayerRecord(
      json['id'] as String,
      json['playerName'] as String,
      $enumDecode(_$EnumWindEnumMap, json['wind']),
      json['points'] as int,
    );

Map<String, dynamic> _$PlayerRecordToJson(PlayerRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerName': instance.playerName,
      'wind': _$EnumWindEnumMap[instance.wind],
      'points': instance.points,
    };

const _$EnumWindEnumMap = {
  EnumWind.east: 'east',
  EnumWind.south: 'south',
  EnumWind.west: 'west',
  EnumWind.north: 'north',
};
