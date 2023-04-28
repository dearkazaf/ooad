import 'dart:math';

import 'package:mahjong_cal/data_entity/transfer_request.dart';
import 'package:mahjong_cal/data_entity/round_result/round_result.dart';

abstract class PointTransferCalculator {
  List<TransferRequest> calculate(RoundResult roundResult, String dealerId);

  int basePointCalculate(int fu, int han) {
    int basePoint = fu * pow(2, han + 2).toInt();
    if (han >= 13) {
      basePoint = 8000;
    } else if (han >= 11) {
      basePoint = 6000;
    } else if (han >= 8) {
      basePoint = 4000;
    } else if (han >= 6) {
      basePoint = 3000;
    } else if (han == 5 || (han == 4 && basePoint >= 2000)) {
      basePoint = 2000;
    }
    return basePoint;
  }

  int hundredRoundUp(int points) {
    return (points / 100).ceil() * 100;
  }
}
