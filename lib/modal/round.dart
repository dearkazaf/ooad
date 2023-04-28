import 'package:equatable/equatable.dart';

import 'package:mahjong_cal/constant/enum_wind.dart';
import 'package:mahjong_cal/constant/enum_round_result_type.dart';
import 'package:mahjong_cal/data_entity/record/round_record.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_result.dart';
import 'package:mahjong_cal/data_entity/round_result/round_result.dart';
import 'package:mahjong_cal/data_entity/round_result/winning_result.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_in_progress_result.dart';
import 'package:mahjong_cal/data_entity/transfer_object/round_transfer_object.dart';

class Round extends Equatable {
  final EnumWind _gameWind;
  final int _gameCount;
  final int _dealerCounter;
  EnumRoundResultType? _resultType;
  final List<RoundResult> _results = [];

  EnumWind get gameWind => _gameWind;
  int get gameCount => _gameCount;
  int get dealerCounter => _dealerCounter;
  EnumRoundResultType? get resultType => _resultType;
  List<RoundResult> get results => _results;

  Round(this._gameWind, this._gameCount, this._dealerCounter);

  void addResult(RoundResult result) {
    if (result is DrawResult) {
      _resultType = EnumRoundResultType.draw;
    } else if (result is DrawInProgressResult) {
      _resultType = EnumRoundResultType.drawInProgress;
    } else if (result is WinningResult) {
      _resultType = EnumRoundResultType.winning;
    }
    results.add(result);
  }

  RoundTransferObject toTransferObject() {
    return RoundTransferObject(_gameWind, _gameCount, _dealerCounter);
  }

  RoundRecord toRecord() {
    List<String> winner = [];
    for (RoundResult r in results) {
      if (r is WinningResult) {
        winner.add(r.winner);
      } else if (r is DrawResult) {
        winner.addAll(r.readyHandPlayers);
      }
    }
    RoundRecord record = RoundRecord(_gameWind, _gameCount, _dealerCounter,
        _resultType ?? EnumRoundResultType.draw, winner);
    return record;
  }

  @override
  List<Object> get props => [_gameWind, _gameCount, _dealerCounter];
}
