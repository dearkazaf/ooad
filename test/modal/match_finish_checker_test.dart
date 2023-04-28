import 'package:mahjong_cal/modal/round.dart';
import 'package:mahjong_cal/modal/player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahjong_cal/constant/enum_wind.dart';
import 'package:mahjong_cal/constant/enum_match_length.dart';
import 'package:mahjong_cal/data_entity/match_setting.dart';
import 'package:mahjong_cal/modal/match_finish_checker.dart';
import 'package:mahjong_cal/constant/enum_match_player_count.dart';

void main() {
  group('MatchFinishChecker', () {
    final MatchFinishChecker checker = MatchFinishChecker();
    test('test true if match length is eastWind and round is not east wind',
        () {
      expect(
          checker.isFinished(
              Round(EnumWind.north, 1, 1),
              const MatchSetting(EnumMatchLength.eastWind,
                  EnumMatchPlayerCount.four, 25000, {}),
              [Player('player1', 'player1', 31000, EnumWind.east)]),
          true);
      expect(
          checker.isFinished(
              Round(EnumWind.east, 1, 1),
              const MatchSetting(EnumMatchLength.eastWind,
                  EnumMatchPlayerCount.four, 25000, {}),
              [Player('player1', 'player1', 31000, EnumWind.east)]),
          false);
    });

    test(
        'test true if match length is half and round is west wind for four player of south wind for three player',
        () {
      expect(
          checker.isFinished(
              Round(EnumWind.west, 1, 1),
              const MatchSetting(
                  EnumMatchLength.half, EnumMatchPlayerCount.four, 25000, {}),
              [Player('player1', 'player1', 31000, EnumWind.east)]),
          true);
      expect(
          checker.isFinished(
              Round(EnumWind.south, 4, 1),
              const MatchSetting(
                  EnumMatchLength.half, EnumMatchPlayerCount.four, 25000, {}),
              [Player('player1', 'player1', 31000, EnumWind.east)]),
          false);
      expect(
          checker.isFinished(
              Round(EnumWind.north, 1, 1),
              const MatchSetting(
                  EnumMatchLength.half, EnumMatchPlayerCount.three, 25000, {}),
              [Player('player1', 'player1', 31000, EnumWind.east)]),
          true);
      expect(
          checker.isFinished(
              Round(EnumWind.east, 4, 1),
              const MatchSetting(
                  EnumMatchLength.half, EnumMatchPlayerCount.three, 25000, {}),
              [Player('player1', 'player1', 31000, EnumWind.east)]),
          false);
    });

    test(
        'test true if match length is full and round is east wind and gameCount is gather 5',
        () {
      expect(
          checker.isFinished(
              Round(EnumWind.east, 5, 1),
              const MatchSetting(
                  EnumMatchLength.fulls, EnumMatchPlayerCount.four, 25000, {}),
              [Player('player1', 'player1', 31000, EnumWind.east)]),
          true);
      expect(
          checker.isFinished(
              Round(EnumWind.north, 4, 1),
              const MatchSetting(
                  EnumMatchLength.fulls, EnumMatchPlayerCount.four, 25000, {}),
              [Player('player1', 'player1', 31000, EnumWind.east)]),
          false);
    });

    test('test false if no player is exceed 30000 points', () {
      expect(
          checker.isFinished(
              Round(EnumWind.east, 5, 1),
              const MatchSetting(
                  EnumMatchLength.fulls, EnumMatchPlayerCount.four, 25000, {}),
              [Player('player1', 'player1', 25000, EnumWind.east)]),
          false);
    });
  });
}
