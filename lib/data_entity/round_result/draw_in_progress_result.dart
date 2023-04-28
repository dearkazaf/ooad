import 'package:json_annotation/json_annotation.dart';
import 'package:mahjong_cal/data_entity/round_result/round_result.dart';

@JsonSerializable()
class DrawInProgressResult extends RoundResult {
  final String drawType;

  DrawInProgressResult(this.drawType);
}
