import 'package:mahjong_cal/constant/enum_wind.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mahjong_cal/constant/enum_round_result_type.dart';

part 'round_record.g.dart';

@JsonSerializable(explicitToJson: true)
class RoundRecord {
  final EnumWind gameWind;
  final int gameCount;
  final int dealerCounter;
  final EnumRoundResultType resultType;
  final List<String> winner;

  RoundRecord(this.gameWind, this.gameCount, this.dealerCounter,
      this.resultType, this.winner);

  factory RoundRecord.fromJson(Map<String, dynamic> json) =>
      _$RoundRecordFromJson(json);
  Map<String, dynamic> toJson() => _$RoundRecordToJson(this);
}
