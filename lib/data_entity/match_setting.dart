import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mahjong_cal/constant/enum_match_length.dart';
import 'package:mahjong_cal/constant/enum_match_player_count.dart';

part 'match_setting.g.dart';

@JsonSerializable()
class MatchSetting extends Equatable {
  final EnumMatchLength matchLength;
  final EnumMatchPlayerCount playerCount;
  final int initPoint;
  final Map<String, String> playerName;

  const MatchSetting(
      this.matchLength, this.playerCount, this.initPoint, this.playerName);

  @override
  List<Object> get props => [matchLength, playerCount, initPoint, playerName];

  factory MatchSetting.fromJson(Map<String, dynamic> json) =>
      _$MatchSettingFromJson(json);
  Map<String, dynamic> toJson() => _$MatchSettingToJson(this);
}
