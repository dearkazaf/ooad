import 'package:mahjong_cal/constant/enum_win_type.dart';
import 'package:mahjong_cal/data_entity/transfer_request.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_result.dart';
import 'package:mahjong_cal/data_entity/round_result/round_result.dart';
import 'package:mahjong_cal/data_entity/round_result/winning_result.dart';
import 'package:mahjong_cal/modal/point_transfer_calculator/point_transfer_calculator.dart';

class FourPlayerPointTransferCalculator extends PointTransferCalculator {
  @override
  List<TransferRequest> calculate(RoundResult roundResult, String dealerId) {
    if (roundResult is DrawResult) {
      return _calculateDrawResult(roundResult);
    } else if (roundResult is WinningResult) {
      return _calculateWinningResult(roundResult, dealerId);
    }
    return [];
  }

  List<TransferRequest> _calculateDrawResult(DrawResult roundResult) {
    List<String> noReadyHandPlayer = [
      'player1',
      'player2',
      'player3',
      'player4'
    ].where((e) => !roundResult.readyHandPlayers.contains(e)).toList();

    List<TransferRequest> result = [];
    if (roundResult.readyHandPlayers.length == 1) {
      result = [
        TransferRequest(
            noReadyHandPlayer[0], roundResult.readyHandPlayers[0], 1000),
        TransferRequest(
            noReadyHandPlayer[1], roundResult.readyHandPlayers[0], 1000),
        TransferRequest(
            noReadyHandPlayer[2], roundResult.readyHandPlayers[0], 1000),
      ];
    } else if (roundResult.readyHandPlayers.length == 2) {
      result = [
        TransferRequest(
            noReadyHandPlayer[0], roundResult.readyHandPlayers[0], 1500),
        TransferRequest(
            noReadyHandPlayer[1], roundResult.readyHandPlayers[1], 1500),
      ];
    } else if (roundResult.readyHandPlayers.length == 3) {
      result = [
        TransferRequest(
            noReadyHandPlayer[0], roundResult.readyHandPlayers[0], 1000),
        TransferRequest(
            noReadyHandPlayer[0], roundResult.readyHandPlayers[1], 1000),
        TransferRequest(
            noReadyHandPlayer[0], roundResult.readyHandPlayers[2], 1000),
      ];
    }
    return result;
  }

  List<TransferRequest> _calculateWinningResult(
      WinningResult roundResult, String dealerId) {
    List<TransferRequest> result = [];
    int basePoint = basePointCalculate(roundResult.fu, roundResult.han);
    if (roundResult.winType == EnumWinType.selfDraw) {
      List<String> payer = ['player1', 'player2', 'player3', 'player4']
          .where((e) => e != roundResult.winner)
          .toList();
      if (dealerId == roundResult.winner) {
        result = [
          TransferRequest(
              payer[0], roundResult.winner, hundredRoundUp(basePoint * 2)),
          TransferRequest(
              payer[1], roundResult.winner, hundredRoundUp(basePoint * 2)),
          TransferRequest(
              payer[2], roundResult.winner, hundredRoundUp(basePoint * 2)),
        ];
      } else {
        result = [
          TransferRequest(payer[0], roundResult.winner,
              hundredRoundUp(basePoint * (payer[0] == dealerId ? 2 : 1))),
          TransferRequest(payer[1], roundResult.winner,
              hundredRoundUp(basePoint * (payer[1] == dealerId ? 2 : 1))),
          TransferRequest(payer[2], roundResult.winner,
              hundredRoundUp(basePoint * (payer[2] == dealerId ? 2 : 1))),
        ];
      }
    } else {
      if (dealerId == roundResult.winner) {
        result = [
          TransferRequest(roundResult.chucker!, roundResult.winner,
              hundredRoundUp(basePoint * 6)),
        ];
      } else {
        result = [
          TransferRequest(roundResult.chucker!, roundResult.winner,
              hundredRoundUp(basePoint * 4)),
        ];
      }
    }
    return result;
  }
}
