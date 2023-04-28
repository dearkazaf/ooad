import 'package:json_annotation/json_annotation.dart';
import 'package:mahjong_cal/data_entity/round_result/round_result.dart';

@JsonSerializable()
class DrawResult extends RoundResult {
  final List<String> readyHandPlayers;

  DrawResult(this.readyHandPlayers);
}
