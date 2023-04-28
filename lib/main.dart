import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:mahjong_cal/page/menu.dart';
import 'package:mahjong_cal/modal/match.dart';
import 'package:mahjong_cal/modal/player.dart';
import 'package:mahjong_cal/page/history_page.dart';
import 'package:mahjong_cal/page/score_board.dart';
import 'package:mahjong_cal/key/navigator_key.dart';
import 'package:mahjong_cal/page/match_create.dart';
import 'package:mahjong_cal/page/connectable_list.dart';
import 'package:mahjong_cal/page/match_settlement.dart';
import 'package:mahjong_cal/page/remote_score_board.dart';
import 'package:mahjong_cal/data_entity/server_info.dart';
import 'package:mahjong_cal/page/player_connect_page.dart';
import 'package:mahjong_cal/modal/network/game_client.dart';
import 'package:mahjong_cal/data_entity/match_setting.dart';
import 'package:mahjong_cal/page/round_result/draw_result_create.dart';
import 'package:mahjong_cal/page/round_result/winning_result_create.dart';
import 'package:mahjong_cal/data_entity/round_result/winning_result.dart';
import 'package:mahjong_cal/page/round_result/draw_in_progress_result_create.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: NavigatorKey.rootNavKey,
      title: '麻將計算機',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        fontFamily: 'Noto Sans CJK',
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                settings: const RouteSettings(name: '/'),
                builder: (_) => const Menu());
          case '/history':
            return MaterialPageRoute(
                settings: const RouteSettings(name: '/history'),
                builder: (_) => const HistoryPage());
          case '/connectable_list':
            return MaterialPageRoute(
                settings: const RouteSettings(name: '/connectable_list'),
                builder: (_) => const ConnectableList());
          case '/player_connect':
            return MaterialPageRoute(
                settings: const RouteSettings(name: '/player_connect'),
                builder: (_) => PlayerConnectPage(
                      info: settings.arguments as ServerInfo,
                    ));
          case '/create_match':
            return MaterialPageRoute(
                settings: const RouteSettings(name: '/create_match'),
                builder: (_) => const MatchCreate());
          case '/score_board':
            return MaterialPageRoute(
                settings: const RouteSettings(name: '/score_board'),
                builder: (_) => ScoreBoard(
                      setting: settings.arguments as MatchSetting,
                    ));
          case '/remote_score_board':
            return MaterialPageRoute(
                settings: const RouteSettings(name: '/remote_score_board'),
                builder: (_) => RemoteScoreBoard(
                      client: settings.arguments as GameClient,
                    ));
          case '/draw_result_create':
            return MaterialPageRoute<List<String>>(
                settings: const RouteSettings(name: '/draw_result_create'),
                builder: (_) => DrawResultCreate(
                      players: settings.arguments as List<Player>,
                    ));
          case '/draw_in_progress_result_create':
            return MaterialPageRoute<String>(
                settings: const RouteSettings(
                    name: '/draw_in_progress_result_create'),
                builder: (_) => const DrawInProgressResultCreate());
          case '/winning_result_create':
            Map<String, dynamic> arguments =
                settings.arguments! as Map<String, dynamic>;
            return MaterialPageRoute<WinningResult>(
                settings: const RouteSettings(name: '/winning_result_create'),
                builder: (_) => WinningResultCreate(
                      players: arguments['players'] as List<Player>,
                      winner: arguments['winner'] as String,
                    ));
          case '/match_settlement':
            return MaterialPageRoute<WinningResult>(
                settings: const RouteSettings(name: '/match_settlement'),
                builder: (_) => MatchSettlement(
                      match: settings.arguments as Match,
                    ));
          default:
            return null;
        }
      },
      builder: EasyLoading.init(
        builder: (BuildContext context, Widget? child) => child ?? Container(),
      ),
    );
  }
}
