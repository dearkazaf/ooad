import 'dart:math';
import 'package:flutter/material.dart';

import 'package:mahjong_cal/data_entity/match_setting.dart';
import 'package:mahjong_cal/constant/enum_match_length.dart';
import 'package:mahjong_cal/component/visibility_widget.dart';
import 'package:mahjong_cal/component/input/number_input.dart';
import 'package:mahjong_cal/constant/enum_match_player_count.dart';
import 'package:mahjong_cal/component/dialog/platform_input_dialog.dart';
import 'package:mahjong_cal/component/button/tab_bar_option_button.dart';

class MatchCreate extends StatefulWidget {
  const MatchCreate({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MatchCreate();
}

class _MatchCreate extends State<MatchCreate> {
  EnumMatchPlayerCount playerCount = EnumMatchPlayerCount.four;
  EnumMatchLength matchLength = EnumMatchLength.eastWind;
  Map<String, String> playerName = {
    'player1': 'player1',
    'player2': 'player2',
    'player3': 'player3',
    'player4': 'player4',
  };
  int initPoint = 25000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('建立'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '人數',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            TabBarOptionButton<EnumMatchPlayerCount>(
              selectedIndex: playerCount,
              index: const [
                EnumMatchPlayerCount.four,
                EnumMatchPlayerCount.three
              ],
              text: const ['四人', '三人'],
              onSelect: (EnumMatchPlayerCount select) {
                setState(() {
                  playerCount = select;
                });
              },
            ),
            const SizedBox(height: 8),
            const Text(
              '長度',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            TabBarOptionButton<EnumMatchLength>(
              selectedIndex: matchLength,
              index: const [
                EnumMatchLength.eastWind,
                EnumMatchLength.half,
                EnumMatchLength.fulls
              ],
              text: const ['東風戰', '半莊', '一莊戰'],
              onSelect: (EnumMatchLength select) {
                setState(() {
                  matchLength = select;
                });
              },
            ),
            const SizedBox(height: 8),
            const Text(
              '起始點數',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            NumberInput(
              number: initPoint,
              onAdd: () {
                setState(() {
                  initPoint += 1000;
                });
              },
              onMinus: () {
                setState(() {
                  initPoint = max(0, initPoint - 1000);
                });
              },
            ),
            const SizedBox(height: 8),
            const Text(
              '玩家名稱',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            IntrinsicHeight(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _onPlayerNameEdit('player1'),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 120),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'player1',
                            ),
                            Text(
                              playerName['player1']!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(33, 150, 243, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => _onPlayerNameEdit('player2'),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 120),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'player2',
                            ),
                            Text(
                              playerName['player2']!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(33, 150, 243, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => _onPlayerNameEdit('player3'),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 120),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'player3',
                            ),
                            Text(
                              playerName['player3']!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(33, 150, 243, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    VisibilityWidget(
                      visibility: playerCount == EnumMatchPlayerCount.four,
                      child: GestureDetector(
                        onTap: () => _onPlayerNameEdit('player4'),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 120),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'player4',
                              ),
                              Text(
                                playerName['player4']!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(33, 150, 243, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: IntrinsicHeight(
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 4,
                blurRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.only(top: 16, bottom: 28),
          child: Container(
            width: double.infinity,
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/score_board',
                  arguments: MatchSetting(
                      matchLength, playerCount, initPoint, playerName)),
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
              ),
              child: const Text(
                '建立',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPlayerNameEdit(String playerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PlatformInputDialog(
          initText: playerName[playerId],
          maxLength: 10,
          title: const Text(
            '輸入玩家名稱',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          okText: '確認',
          onInputSubmit: (String text) => setState(() {
            playerName[playerId] = text;
          }),
        );
      },
    );
  }
}
