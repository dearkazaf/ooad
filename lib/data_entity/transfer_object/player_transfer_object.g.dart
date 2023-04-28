// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_transfer_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerTransferObject _$PlayerTransferObjectFromJson(
        Map<String, dynamic> json) =>
    PlayerTransferObject(
      json['id'] as String,
      json['playerName'] as String,
      $enumDecode(_$EnumWindEnumMap, json['wind']),
      json['points'] as int,
      json['status'] as int,
    );

Map<String, dynamic> _$PlayerTransferObjectToJson(
        PlayerTransferObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerName': instance.playerName,
      'wind': _$EnumWindEnumMap[instance.wind],
      'points': instance.points,
      'status': instance.status,
    };

const _$EnumWindEnumMap = {
  EnumWind.east: 'east',
  EnumWind.south: 'south',
  EnumWind.west: 'west',
  EnumWind.north: 'north',
};
