import 'package:flutter_test/flutter_test.dart';
import 'package:mahjong_cal/constant/enum_match_length.dart';
import 'package:mahjong_cal/constant/enum_match_player_count.dart';
import 'package:mahjong_cal/constant/enum_wind.dart';
import 'package:mahjong_cal/constant/player_status.dart';
import 'package:mahjong_cal/data_entity/match_setting.dart';
import 'package:mahjong_cal/data_entity/record/match_record.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_result.dart';
import 'package:mahjong_cal/data_entity/transfer_object/match_transfer_object.dart';
import 'package:mahjong_cal/modal/match.dart';

void main() {
  group('Match', () {
    test('Match Create', () {
      MatchSetting setting = const MatchSetting(
          EnumMatchLength.eastWind, EnumMatchPlayerCount.four, 25000, {
        'player1': 'player11',
        'player2': 'player22',
        'player3': 'player33',
        'player4': 'player44',
      });
      Match match = Match(setting);
      expect(match.players['player1']!.playerName, "player11");
      expect(match.players['player2']!.playerName, "player22");
      expect(match.players['player3']!.playerName, "player33");
      expect(match.players['player4']!.playerName, "player44");
    });

    test('Match Dealer Id', () {
      MatchSetting setting = const MatchSetting(
          EnumMatchLength.eastWind, EnumMatchPlayerCount.four, 25000, {
        'player1': 'player11',
        'player2': 'player22',
        'player3': 'player33',
        'player4': 'player44',
      });
      Match match = Match(setting);
      expect(match.getDealerId(), "player1");
    });

    test('Match Check Status', () {
      MatchSetting setting = const MatchSetting(
          EnumMatchLength.eastWind, EnumMatchPlayerCount.four, 25000, {
        'player1': 'player11',
        'player2': 'player22',
        'player3': 'player33',
        'player4': 'player44',
      });
      Match match = Match(setting);
      match.playerConnect("player1");
      expect(
          true, match.players["player1"]!.checkStatus(PlayerStatus.connected));
      match.playerDisconnect("player1");
      expect(
          false, match.players["player1"]!.checkStatus(PlayerStatus.connected));
      match.clamRichi("player1");
      expect(true, match.players["player1"]!.checkStatus(PlayerStatus.richi));
    });

    test('Match Round Progress', () {
      MatchSetting setting = const MatchSetting(
          EnumMatchLength.eastWind, EnumMatchPlayerCount.four, 25000, {
        'player1': 'player11',
        'player2': 'player22',
        'player3': 'player33',
        'player4': 'player44',
      });
      Match match = Match(setting);
      match.setRoundResult(DrawResult(["player2"]));
      match.settle();
      expect(match.currentRound.gameWind, EnumWind.east);
      expect(match.currentRound.gameCount, 2);
      expect(match.players['player1']!.points, 24000);
      expect(match.players['player2']!.points, 28000);
      expect(match.players['player3']!.points, 24000);
      expect(match.players['player4']!.points, 24000);
    });

    test('Match toTransferObject', () {
      MatchSetting setting = const MatchSetting(
          EnumMatchLength.eastWind, EnumMatchPlayerCount.four, 25000, {
        'player1': 'player11',
        'player2': 'player22',
        'player3': 'player33',
        'player4': 'player44',
      });
      Match match = Match(setting);
      MatchTransferObject transferObject = match.toTransferObject();
      expect(transferObject.round.gameWind, EnumWind.east);
      expect(transferObject.players['player1']!.playerName, "player11");
      expect(transferObject.players['player2']!.playerName, "player22");
      expect(transferObject.players['player3']!.playerName, "player33");
      expect(transferObject.players['player4']!.playerName, "player44");
    });

    test('Match toRecord', () {
      MatchSetting setting = const MatchSetting(
          EnumMatchLength.eastWind, EnumMatchPlayerCount.four, 25000, {
        'player1': 'player11',
        'player2': 'player22',
        'player3': 'player33',
        'player4': 'player44',
      });
      Match match = Match(setting);
      match.setRoundResult(DrawResult(["player1"]));
      match.settle();
      MatchRecord record = match.toRecord();
      expect(record.rounds[0].winner, ["player1"]);
      expect(record.players['player1']!.points, 28000);
      expect(record.players['player2']!.points, 24000);
      expect(record.players['player3']!.points, 24000);
      expect(record.players['player4']!.points, 24000);
    });
  });
}
