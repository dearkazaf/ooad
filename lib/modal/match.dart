import 'package:flutter/material.dart';
import 'package:mahjong_cal/modal/round.dart';
import 'package:mahjong_cal/modal/player.dart';
import 'package:mahjong_cal/constant/enum_wind.dart';
import 'package:mahjong_cal/modal/round_generator.dart';
import 'package:mahjong_cal/constant/player_status.dart';
import 'package:mahjong_cal/data_entity/match_setting.dart';
import 'package:mahjong_cal/constant/wind_transfer_map.dart';
import 'package:mahjong_cal/modal/match_finish_checker.dart';
import 'package:mahjong_cal/data_entity/transfer_request.dart';
import 'package:mahjong_cal/data_entity/record/match_record.dart';
import 'package:mahjong_cal/data_entity/record/round_record.dart';
import 'package:mahjong_cal/constant/enum_round_result_type.dart';
import 'package:mahjong_cal/data_entity/record/player_record.dart';
import 'package:mahjong_cal/constant/enum_match_player_count.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_result.dart';
import 'package:mahjong_cal/data_entity/round_result/round_result.dart';
import 'package:mahjong_cal/data_entity/round_result/winning_result.dart';
import 'package:mahjong_cal/data_entity/transfer_object/match_transfer_object.dart';
import 'package:mahjong_cal/data_entity/transfer_object/player_transfer_object.dart';
import 'package:mahjong_cal/modal/point_transfer_calculator/point_transfer_calculator.dart';
import 'package:mahjong_cal/modal/point_transfer_calculator/four_player_point_transfer_calculator.dart';
import 'package:mahjong_cal/modal/point_transfer_calculator/three_player_point_transfer_calculator.dart';

class Match {
  final MatchSetting _setting;
  late Map<String, Player> _players;
  Round _currentRound;
  final List<Round> _rounds = [];
  final List<VoidCallback> _onUpdate = [];

  Round get currentRound => _currentRound;
  List<Round> get rounds => _rounds;
  MatchSetting get setting => _setting;
  Map<String, Player> get players => _players;

  set onUpdate(VoidCallback callback) {
    _onUpdate.add(callback);
  }

  Match(this._setting) : _currentRound = Round(EnumWind.east, 1, 0) {
    if (_setting.playerCount == EnumMatchPlayerCount.three) {
      _players = {
        'player1': Player(
            'player1',
            _setting.playerName['player1'] ?? 'player1',
            _setting.initPoint,
            EnumWind.east),
        'player2': Player(
            'player2',
            _setting.playerName['player2'] ?? 'player2',
            _setting.initPoint,
            EnumWind.south),
        'player3': Player(
            'player3',
            _setting.playerName['player3'] ?? 'player3',
            _setting.initPoint,
            EnumWind.west),
      };
    } else if (_setting.playerCount == EnumMatchPlayerCount.four) {
      _players = {
        'player1': Player(
            'player1',
            _setting.playerName['player1'] ?? 'player1',
            _setting.initPoint,
            EnumWind.east),
        'player2': Player(
            'player2',
            _setting.playerName['player2'] ?? 'player2',
            _setting.initPoint,
            EnumWind.south),
        'player3': Player(
            'player3',
            _setting.playerName['player3'] ?? 'player3',
            _setting.initPoint,
            EnumWind.west),
        'player4': Player(
            'player4',
            _setting.playerName['player4'] ?? 'player4',
            _setting.initPoint,
            EnumWind.north),
      };
    }
  }

  MatchTransferObject toTransferObject() {
    Map<String, PlayerTransferObject> transferPlayer = {};
    for (String playerId in _players.keys) {
      transferPlayer[playerId] = _players[playerId]!.toTransferObject();
    }
    return MatchTransferObject(transferPlayer, currentRound.toTransferObject());
  }

  MatchRecord toRecord() {
    Map<String, PlayerRecord> playerRecords = {};
    for (Player p in players.values) {
      playerRecords[p.id] = p.toRecord();
    }
    List<RoundRecord> roundRecords = rounds.map((e) => e.toRecord()).toList();
    MatchRecord record = MatchRecord(setting, roundRecords, playerRecords);
    return record;
  }

  String getDealerId() {
    String result = "";
    _players.forEach((id, player) {
      if (player.isDealer) result = id;
    });
    return result;
  }

  void playerConnect(String playerId) {
    _players[playerId]!.setStatus(PlayerStatus.connected);
    _singleUpdate();
  }

  void playerDisconnect(String playerId) {
    players[playerId]!.removeState(PlayerStatus.connected);
    _singleUpdate();
  }

  void clamRichi(String playerId) {
    Player player = _players[playerId]!;
    if (player.points >= 1000) {
      player.setStatus(PlayerStatus.richi);
      player.transfer(null, 1000);
    }
    _singleUpdate();
  }

  void setRoundResult(RoundResult result) {
    _currentRound.addResult(result);
  }

  void settle() {
    List<RoundResult> results = _currentRound.results;
    List<TransferRequest> requests = [];
    PointTransferCalculator calculator =
        _setting.playerCount == EnumMatchPlayerCount.four
            ? FourPlayerPointTransferCalculator()
            : ThreePlayerPointTransferCalculator();
    String dealerId = getDealerId();
    for (RoundResult result in results) {
      requests.addAll(calculator.calculate(result, dealerId));
    }
    for (TransferRequest result in requests) {
      _players[result.from]!.transfer(_players[result.to]!, result.amount);
    }
    _nextRound();
    _singleUpdate();
  }

  bool isFinished() {
    MatchFinishChecker checker = MatchFinishChecker();
    return checker.isFinished(
        _currentRound, _setting, _players.values.toList());
  }

  void _singleUpdate() {
    for (VoidCallback callback in _onUpdate) {
      callback();
    }
  }

  void _nextRound() {
    _rounds.add(_currentRound);
    bool isDealerRemaining = _isDealerRemaining();
    RoundGenerator generator = RoundGenerator();
    _currentRound =
        generator.generate(_currentRound, _setting, isDealerRemaining);
    for (Player player in _players.values) {
      player.removeState(PlayerStatus.richi);
      if (!isDealerRemaining) {
        player.wind = _setting.playerCount == EnumMatchPlayerCount.four
            ? fourPlayerWindTransfer[player.wind]!
            : threePlayerWindTransfer[player.wind]!;
      }
    }
  }

  bool _isDealerRemaining() {
    if (_currentRound.resultType == EnumRoundResultType.drawInProgress) {
      return true;
    } else if (_currentRound.resultType == EnumRoundResultType.draw) {
      DrawResult result = _currentRound.results.first as DrawResult;
      return result.readyHandPlayers.contains(getDealerId());
    } else if (_currentRound.resultType == EnumRoundResultType.winning) {
      List<RoundResult> results = _currentRound.results;
      return results
          .where((result) => (result as WinningResult).winner == getDealerId())
          .isNotEmpty;
    }
    return false;
  }
}
