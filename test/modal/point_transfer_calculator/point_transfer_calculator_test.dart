import 'package:flutter_test/flutter_test.dart';
import 'package:mahjong_cal/modal/point_transfer_calculator/point_transfer_calculator.dart';
import 'package:mahjong_cal/modal/point_transfer_calculator/four_player_point_transfer_calculator.dart';

void main() {
  group('PointTransferCalculator', () {
    PointTransferCalculator calculator = FourPlayerPointTransferCalculator();
    group('basePoint', () {
      test('test han >= 13', () {
        int basePoint = calculator.basePointCalculate(20, 13);
        expect(basePoint, 8000);
      });

      test('test han >= 11 and <= 12', () {
        int basePoint = calculator.basePointCalculate(20, 11);
        expect(basePoint, 6000);
      });

      test('test han >= 8 and <= 10', () {
        int basePoint = calculator.basePointCalculate(20, 8);
        expect(basePoint, 4000);
      });

      test('test han >= 6 and <= 7', () {
        int basePoint = calculator.basePointCalculate(20, 6);
        expect(basePoint, 3000);
      });

      test('test han == 5', () {
        int basePoint = calculator.basePointCalculate(20, 5);
        expect(basePoint, 2000);
      });

      test('test han == 4 and fu >31', () {
        int basePoint = calculator.basePointCalculate(32, 4);
        expect(basePoint, 2000);
      });

      test('test other condition', () {
        int basePoint = calculator.basePointCalculate(30, 1);
        expect(basePoint, 240);
      });
    });

    test('test hundredRoundUp', () {
      int result = calculator.hundredRoundUp(1240);
      expect(result, 1300);
    });
  });
}
