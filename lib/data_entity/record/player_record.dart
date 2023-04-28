import 'package:json_annotation/json_annotation.dart';
import 'package:mahjong_cal/constant/enum_wind.dart';

part 'player_record.g.dart';

@JsonSerializable()
class PlayerRecord {
  final String id;
  final String playerName;
  final EnumWind wind;
  final int points;

  PlayerRecord(this.id, this.playerName, this.wind, this.points);

  factory PlayerRecord.fromJson(Map<String, dynamic> json) =>
      _$PlayerRecordFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerRecordToJson(this);
}
