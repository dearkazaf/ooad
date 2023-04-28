import 'package:mahjong_cal/modal/round.dart';
import 'package:mahjong_cal/modal/player.dart';
import 'package:mahjong_cal/constant/enum_wind.dart';
import 'package:mahjong_cal/data_entity/match_setting.dart';
import 'package:mahjong_cal/constant/enum_match_length.dart';
import 'package:mahjong_cal/constant/enum_match_player_count.dart';

class MatchFinishChecker {
  bool isFinished(
      Round currentRound, MatchSetting setting, List<Player> players) {
    return _checkPlayerKnockOut(players) ||
        (_checkMatchLength(currentRound, setting) &&
            _checkPlayerPoint(players));
  }

  bool _checkPlayerKnockOut(List<Player> players) {
    return players.where((player) => player.points < 0).isNotEmpty;
  }

  bool _checkMatchLength(Round currentRound, MatchSetting setting) {
    if (setting.matchLength == EnumMatchLength.eastWind &&
        currentRound.gameWind != EnumWind.east) {
      return true;
    } else if (setting.matchLength == EnumMatchLength.half &&
        ((currentRound.gameWind.index > EnumWind.south.index &&
                setting.playerCount == EnumMatchPlayerCount.four) ||
            (currentRound.gameWind.index > EnumWind.east.index &&
                setting.playerCount == EnumMatchPlayerCount.three))) {
      return true;
    } else if (setting.matchLength == EnumMatchLength.fulls &&
        currentRound.gameWind == EnumWind.east &&
        currentRound.gameCount >= 5) {
      return true;
    }
    return false;
  }

  bool _checkPlayerPoint(List<Player> players) {
    return players.where((player) => player.points > 30000).isNotEmpty;
  }
}
