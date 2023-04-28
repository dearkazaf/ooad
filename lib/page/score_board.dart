import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mahjong_cal/modal/match.dart';
import 'package:mahjong_cal/data_entity/match_setting.dart';
import 'package:mahjong_cal/modal/network/game_server.dart';
import 'package:mahjong_cal/constant/enum_match_player_count.dart';
import 'package:mahjong_cal/section/score_board/four_player_score_board.dart';
import 'package:mahjong_cal/section/score_board/three_player_score_board.dart';

class ScoreBoard extends StatefulWidget {
  final Match match;

  ScoreBoard({Key? key, required MatchSetting setting})
      : match = Match(setting),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ScoreBoard();
}

class _ScoreBoard extends State<ScoreBoard> {
  late GameServer server;

  @override
  void initState() {
    super.initState();
    server = GameServer(widget.match);
    server.start();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  void dispose() {
    server.stop();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.match.setting.playerCount == EnumMatchPlayerCount.four
          ? FourPlayerScoreBoard(match: widget.match)
          : ThreePlayerScoreBoard(match: widget.match),
    );
  }
}
