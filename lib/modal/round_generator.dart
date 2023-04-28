import 'package:mahjong_cal/modal/round.dart';
import 'package:mahjong_cal/constant/enum_wind.dart';
import 'package:mahjong_cal/data_entity/match_setting.dart';
import 'package:mahjong_cal/constant/wind_transfer_map.dart';
import 'package:mahjong_cal/constant/enum_match_player_count.dart';

class RoundGenerator {
  Round generate(
      Round currentRound, MatchSetting setting, bool isDealerRemaining) {
    if (isDealerRemaining) {
      return Round(currentRound.gameWind, currentRound.gameCount,
          currentRound.dealerCounter + 1);
    }
    if (setting.playerCount == EnumMatchPlayerCount.three) {
      return _generateThreePlayerNewRound(currentRound);
    }
    return _generateFourPlayerNewRound(currentRound);
  }

  Round _generateFourPlayerNewRound(Round currentRound) {
    if (currentRound.gameWind == EnumWind.north &&
        currentRound.gameCount == 4) {
      return Round(EnumWind.east, 5, 0);
    } else if (currentRound.gameCount == 4) {
      return Round(fourPlayerRoundWindTransfer[currentRound.gameWind]!, 1, 0);
    } else {
      return Round(currentRound.gameWind, currentRound.gameCount + 1, 0);
    }
  }

  Round _generateThreePlayerNewRound(Round currentRound) {
    if (currentRound.gameWind == EnumWind.west && currentRound.gameCount == 3) {
      return Round(EnumWind.east, 4, 0);
    } else if (currentRound.gameCount == 3) {
      return Round(threePlayerRoundWindTransfer[currentRound.gameWind]!, 1, 0);
    } else {
      return Round(currentRound.gameWind, currentRound.gameCount + 1, 0);
    }
  }
}
