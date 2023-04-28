import 'package:json_annotation/json_annotation.dart';
import 'package:mahjong_cal/constant/enum_win_type.dart';
import 'package:mahjong_cal/data_entity/round_result/round_result.dart';

@JsonSerializable()
class WinningResult extends RoundResult {
  final EnumWinType winType;
  final String winner;
  String? chucker;
  final List<String> tile;
  final int han;
  final int fu;
  int point = 0;

  WinningResult(this.winner, this.winType, this.tile, this.han, this.fu,
      {this.chucker, int? point = 0}) {
    point = point;
  }
}
