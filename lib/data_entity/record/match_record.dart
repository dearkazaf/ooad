import 'package:json_annotation/json_annotation.dart';
import 'package:mahjong_cal/data_entity/match_setting.dart';
import 'package:mahjong_cal/data_entity/record/round_record.dart';
import 'package:mahjong_cal/data_entity/record/player_record.dart';

part 'match_record.g.dart';

@JsonSerializable(explicitToJson: true)
class MatchRecord {
  final MatchSetting setting;
  final List<RoundRecord> rounds;
  final Map<String, PlayerRecord> players;

  MatchRecord(this.setting, this.rounds, this.players);

  factory MatchRecord.fromJson(Map<String, dynamic> json) =>
      _$MatchRecordFromJson(json);
  Map<String, dynamic> toJson() => _$MatchRecordToJson(this);
}
