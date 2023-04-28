import 'package:flutter_test/flutter_test.dart';

import 'package:mahjong_cal/constant/enum_win_type.dart';
import 'package:mahjong_cal/data_entity/transfer_request.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_result.dart';
import 'package:mahjong_cal/data_entity/round_result/winning_result.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_in_progress_result.dart';
import 'package:mahjong_cal/modal/point_transfer_calculator/three_player_point_transfer_calculator.dart';

void main() {
  group('ThreePlayerPointTransferCalculator', () {
    ThreePlayerPointTransferCalculator calculator =
        ThreePlayerPointTransferCalculator();
    group('draw result', () {
      test('test calculate no one player readyHand', () {
        DrawResult result = DrawResult([]);
        List<TransferRequest> request = calculator.calculate(result, "player1");
        expect(request.length, 0);
      });

      test('test calculate one player readyHand', () {
        DrawResult result = DrawResult(["player2"]);
        List<TransferRequest> request = calculator.calculate(result, "player1");
        expect(request.length, 2);
        expect(request[0], const TransferRequest("player1", "player2", 1500));
        expect(request[1], const TransferRequest("player3", "player2", 1500));
      });

      test('test calculate two player readyHand', () {
        DrawResult result = DrawResult(["player2", "player4"]);
        List<TransferRequest> request = calculator.calculate(result, "player1");
        expect(request.length, 2);
        expect(request[0], const TransferRequest("player1", "player2", 1500));
        expect(request[1], const TransferRequest("player1", "player4", 1500));
      });

      test('test calculate three player readyHand', () {
        DrawResult result = DrawResult(["player1", "player2", "player3"]);
        List<TransferRequest> request = calculator.calculate(result, "player1");
        expect(request.length, 0);
      });
    });

    group('draw in progress result', () {
      test('test skip', () {
        DrawInProgressResult result = DrawInProgressResult("四風連打");
        List<TransferRequest> request = calculator.calculate(result, "player1");
        expect(request.length, 0);
      });
    });

    group('winning result', () {
      test('test dealer selfDraw', () {
        WinningResult result =
            WinningResult("player1", EnumWinType.selfDraw, ['國士無雙'], 13, 20);
        List<TransferRequest> request = calculator.calculate(result, "player1");
        expect(request.length, 2);
        expect(request[0], const TransferRequest("player2", "player1", 16000));
        expect(request[1], const TransferRequest("player3", "player1", 16000));
      });

      test('test dealer ron', () {
        WinningResult result = WinningResult(
            "player1", EnumWinType.ron, ['國士無雙'], 13, 20,
            chucker: 'player2');
        List<TransferRequest> request = calculator.calculate(result, "player1");
        expect(request.length, 1);
        expect(request[0], const TransferRequest("player2", "player1", 48000));
      });

      test('test player selfDraw', () {
        WinningResult result =
            WinningResult("player2", EnumWinType.selfDraw, ['國士無雙'], 13, 20);
        List<TransferRequest> request = calculator.calculate(result, "player1");
        expect(request.length, 2);
        expect(request[0], const TransferRequest("player1", "player2", 16000));
        expect(request[1], const TransferRequest("player3", "player2", 8000));
      });

      test('test player ron', () {
        WinningResult result = WinningResult(
            "player2", EnumWinType.ron, ['國士無雙'], 13, 20,
            chucker: 'player3');
        List<TransferRequest> request = calculator.calculate(result, "player1");
        expect(request.length, 1);
        expect(request[0], const TransferRequest("player3", "player2", 32000));
      });
    });
  });
}
