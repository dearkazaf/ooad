// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoundRecord _$RoundRecordFromJson(Map<String, dynamic> json) => RoundRecord(
      $enumDecode(_$EnumWindEnumMap, json['gameWind']),
      json['gameCount'] as int,
      json['dealerCounter'] as int,
      $enumDecode(_$EnumRoundResultTypeEnumMap, json['resultType']),
      (json['winner'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RoundRecordToJson(RoundRecord instance) =>
    <String, dynamic>{
      'gameWind': _$EnumWindEnumMap[instance.gameWind],
      'gameCount': instance.gameCount,
      'dealerCounter': instance.dealerCounter,
      'resultType': _$EnumRoundResultTypeEnumMap[instance.resultType],
      'winner': instance.winner,
    };

const _$EnumWindEnumMap = {
  EnumWind.east: 'east',
  EnumWind.south: 'south',
  EnumWind.west: 'west',
  EnumWind.north: 'north',
};

const _$EnumRoundResultTypeEnumMap = {
  EnumRoundResultType.draw: 'draw',
  EnumRoundResultType.drawInProgress: 'drawInProgress',
  EnumRoundResultType.winning: 'winning',
};
