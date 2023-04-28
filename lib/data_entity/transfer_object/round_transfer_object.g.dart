// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_transfer_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoundTransferObject _$RoundTransferObjectFromJson(Map<String, dynamic> json) =>
    RoundTransferObject(
      $enumDecode(_$EnumWindEnumMap, json['gameWind']),
      json['gameCount'] as int,
      json['dealerCounter'] as int,
    );

Map<String, dynamic> _$RoundTransferObjectToJson(
        RoundTransferObject instance) =>
    <String, dynamic>{
      'gameWind': _$EnumWindEnumMap[instance.gameWind],
      'gameCount': instance.gameCount,
      'dealerCounter': instance.dealerCounter,
    };

const _$EnumWindEnumMap = {
  EnumWind.east: 'east',
  EnumWind.south: 'south',
  EnumWind.west: 'west',
  EnumWind.north: 'north',
};
