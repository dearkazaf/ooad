import 'package:flutter/material.dart';

import 'package:mahjong_cal/modal/round.dart';
import 'package:mahjong_cal/modal/player.dart';
import 'package:mahjong_cal/constant/player_status.dart';
import 'package:mahjong_cal/constant/wind_translate_map.dart';
import 'package:mahjong_cal/component/button/richi_button.dart';
import 'package:mahjong_cal/component/text/player_wind_text.dart';
import 'package:mahjong_cal/constant/enum_match_player_count.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_result.dart';
import 'package:mahjong_cal/component/button/round_result_button.dart';
import 'package:mahjong_cal/data_entity/round_result/round_result.dart';
import 'package:mahjong_cal/data_entity/round_result/draw_in_progress_result.dart';

class FourPlayerScoreBoardCenter extends StatelessWidget {
  final ValueChanged<String> onRichiClick;
  final ValueChanged<RoundResult> onHasResult;
  final VoidCallback onSettle;
  final Round round;
  final Map<String, Player> players;

  const FourPlayerScoreBoardCenter(
      {Key? key,
      required this.onRichiClick,
      required this.round,
      required this.players,
      required this.onHasResult,
      required this.onSettle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.65;
    double buttonHigh = 28;
    return Container(
      width: height + 20,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 6),
              RotatedBox(
                quarterTurns: 2,
                child: PlayerWindText(wind: players['player3']!.wind),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: SizedBox(
                  height: buttonHigh,
                  child: RichiButton(
                    onClick: () => onRichiClick('player3'),
                    isRichi:
                        players['player3']!.checkStatus(PlayerStatus.richi),
                  ),
                ),
              ),
              RotatedBox(
                quarterTurns: -1,
                child: PlayerWindText(wind: players['player2']!.wind),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: buttonHigh,
                    child: RichiButton(
                      onClick: () => onRichiClick('player4'),
                      isRichi:
                          players['player4']!.checkStatus(PlayerStatus.richi),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${windTranslate[round.gameWind]}${round.gameCount}局',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${round.dealerCounter}本場',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RoundResultButton(
                        settleMode: round.resultType != null,
                        onSettle: () => onSettle(),
                        onDraw: () async {
                          List<String>? readyHandPlayers =
                              await Navigator.pushNamed<List<String>>(
                                  context, '/draw_result_create',
                                  arguments: players.values.toList());
                          if (readyHandPlayers != null) {
                            onHasResult(DrawResult(readyHandPlayers));
                          }
                        },
                        onDrawInProgress: () async {
                          String? drawType = await Navigator.pushNamed<String>(
                              context, '/draw_in_progress_result_create');
                          if (drawType != null) {
                            onHasResult(DrawInProgressResult(drawType));
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: double.infinity,
                    width: buttonHigh,
                    child: RichiButton(
                      onClick: () => onRichiClick('player2'),
                      isRichi:
                          players['player2']!.checkStatus(PlayerStatus.richi),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: PlayerWindText(wind: players['player4']!.wind),
              ),
              Expanded(
                child: SizedBox(
                  height: buttonHigh,
                  child: RichiButton(
                    onClick: () => onRichiClick('player1'),
                    isRichi:
                        players['player1']!.checkStatus(PlayerStatus.richi),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              PlayerWindText(wind: players['player1']!.wind),
              const SizedBox(width: 6),
            ],
          )
        ],
      ),
    );
  }
}
