import 'package:mahjong_cal/modal/round.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahjong_cal/constant/enum_wind.dart';
import 'package:mahjong_cal/modal/round_generator.dart';
import 'package:mahjong_cal/data_entity/match_setting.dart';
import 'package:mahjong_cal/constant/enum_match_length.dart';
import 'package:mahjong_cal/constant/enum_match_player_count.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_result.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_in_progress_result.dart';

void main() {
  group('RoundGenerator', () {
    final RoundGenerator generator = RoundGenerator();
    test('test dealer counter +1 if dealer remain', () {
      Round round = Round(EnumWind.east, 1, 0);
      round.addResult(DrawInProgressResult("國士無雙"));
      expect(
          generator.generate(
              round,
              const MatchSetting(EnumMatchLength.eastWind,
                  EnumMatchPlayerCount.four, 25000, {}),
              true),
          Round(EnumWind.east, 1, 1));
    });

    group('four player', () {
      test('test gameCount progress', () {
        Round round = Round(EnumWind.east, 1, 0);
        round.addResult(DrawResult([]));
        expect(
            generator.generate(
                round,
                const MatchSetting(EnumMatchLength.eastWind,
                    EnumMatchPlayerCount.four, 25000, {}),
                false),
            Round(EnumWind.east, 2, 0));
      });

      test('test gameWind progress', () {
        Round round = Round(EnumWind.east, 4, 0);
        round.addResult(DrawResult([]));
        expect(
            generator.generate(
                round,
                const MatchSetting(EnumMatchLength.eastWind,
                    EnumMatchPlayerCount.four, 25000, {}),
                false),
            Round(EnumWind.south, 1, 0));
      });

      test('test return east', () {
        Round round = Round(EnumWind.north, 4, 0);
        round.addResult(DrawResult([]));
        expect(
            generator.generate(
                round,
                const MatchSetting(EnumMatchLength.eastWind,
                    EnumMatchPlayerCount.four, 25000, {}),
                false),
            Round(EnumWind.east, 5, 0));
      });
    });

    group('three player', () {
      test('test gameCount progress', () {
        Round round = Round(EnumWind.east, 1, 0);
        round.addResult(DrawResult([]));
        expect(
            generator.generate(
                round,
                const MatchSetting(EnumMatchLength.eastWind,
                    EnumMatchPlayerCount.three, 25000, {}),
                false),
            Round(EnumWind.east, 2, 0));
      });

      test('test gameWind progress', () {
        Round round = Round(EnumWind.east, 3, 0);
        round.addResult(DrawResult([]));
        expect(
            generator.generate(
                round,
                const MatchSetting(EnumMatchLength.eastWind,
                    EnumMatchPlayerCount.three, 25000, {}),
                false),
            Round(EnumWind.south, 1, 0));
      });

      test('test return east', () {
        Round round = Round(EnumWind.west, 3, 0);
        round.addResult(DrawResult([]));
        expect(
            generator.generate(
                round,
                const MatchSetting(EnumMatchLength.eastWind,
                    EnumMatchPlayerCount.three, 25000, {}),
                false),
            Round(EnumWind.east, 4, 0));
      });
    });
  });
}
