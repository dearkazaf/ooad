// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchRecord _$MatchRecordFromJson(Map<String, dynamic> json) => MatchRecord(
      MatchSetting.fromJson(json['setting'] as Map<String, dynamic>),
      (json['rounds'] as List<dynamic>)
          .map((e) => RoundRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['players'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, PlayerRecord.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$MatchRecordToJson(MatchRecord instance) =>
    <String, dynamic>{
      'setting': instance.setting.toJson(),
      'rounds': instance.rounds.map((e) => e.toJson()).toList(),
      'players': instance.players.map((k, e) => MapEntry(k, e.toJson())),
    };
