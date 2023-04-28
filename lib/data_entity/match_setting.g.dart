// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchSetting _$MatchSettingFromJson(Map<String, dynamic> json) => MatchSetting(
      $enumDecode(_$EnumMatchLengthEnumMap, json['matchLength']),
      $enumDecode(_$EnumMatchPlayerCountEnumMap, json['playerCount']),
      json['initPoint'] as int,
      Map<String, String>.from(json['playerName'] as Map),
    );

Map<String, dynamic> _$MatchSettingToJson(MatchSetting instance) =>
    <String, dynamic>{
      'matchLength': _$EnumMatchLengthEnumMap[instance.matchLength],
      'playerCount': _$EnumMatchPlayerCountEnumMap[instance.playerCount],
      'initPoint': instance.initPoint,
      'playerName': instance.playerName,
    };

const _$EnumMatchLengthEnumMap = {
  EnumMatchLength.eastWind: 'eastWind',
  EnumMatchLength.half: 'half',
  EnumMatchLength.fulls: 'fulls',
};

const _$EnumMatchPlayerCountEnumMap = {
  EnumMatchPlayerCount.three: 'three',
  EnumMatchPlayerCount.four: 'four',
};
