import 'package:flutter/material.dart';

import 'package:mahjong_cal/modal/match.dart';
import 'package:mahjong_cal/constant/player_status.dart';
import 'package:mahjong_cal/component/visibility_widget.dart';
import 'package:mahjong_cal/data_entity/round_result/round_result.dart';
import 'package:mahjong_cal/data_entity/round_result/winning_result.dart';
import 'package:mahjong_cal/section/score_board/four_player_score_board_center.dart';

class FourPlayerScoreBoard extends StatefulWidget {
  final Match match;

  const FourPlayerScoreBoard({Key? key, required this.match}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FourPlayerScoreBoard();
}

class _FourPlayerScoreBoard extends State<FourPlayerScoreBoard> {
  @override
  void initState() {
    super.initState();
    widget.match.onUpdate = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: GestureDetector(
                  onTap: () async => _onWinning('player3'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      VisibilityWidget(
                        visibility: widget.match.players['player3']!
                            .checkStatus(PlayerStatus.connected),
                        child: const Icon(
                          Icons.wifi,
                          size: 16,
                        ),
                      ),
                      Text(
                        widget.match.players['player3']!.playerName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: GestureDetector(
                  onTap: () async => _onWinning('player4'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      VisibilityWidget(
                          visibility: widget.match.players['player4']!
                              .checkStatus(PlayerStatus.connected),
                          child: const Icon(
                            Icons.wifi,
                            size: 16,
                          )),
                      Text(
                        widget.match.players['player4']!.playerName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: Text(
                  widget.match.players['player3']!.points.toString(),
                  style: const TextStyle(
                    color: Color.fromRGBO(33, 150, 243, 1),
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      widget.match.players['player4']!.points.toString(),
                      style: const TextStyle(
                        color: Color.fromRGBO(33, 150, 243, 1),
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  FourPlayerScoreBoardCenter(
                    onRichiClick: (String playerId) {
                      setState(() {
                        widget.match.clamRichi(playerId);
                      });
                    },
                    onHasResult: (RoundResult result) {
                      widget.match.setRoundResult(result);
                      widget.match.settle();
                      if (widget.match.isFinished()) {
                        Navigator.pushNamed(context, '/match_settlement',
                            arguments: widget.match);
                      }
                      setState(() {});
                    },
                    onSettle: () {
                      widget.match.settle();
                      if (widget.match.isFinished()) {
                        Navigator.pushNamed(context, '/match_settlement',
                            arguments: widget.match);
                      }
                      setState(() {});
                    },
                    players: widget.match.players,
                    round: widget.match.currentRound,
                  ),
                  RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      widget.match.players['player2']!.points.toString(),
                      style: const TextStyle(
                        color: Color.fromRGBO(33, 150, 243, 1),
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.match.players['player1']!.points.toString(),
                style: const TextStyle(
                  color: Color.fromRGBO(33, 150, 243, 1),
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RotatedBox(
                quarterTurns: -1,
                child: GestureDetector(
                  onTap: () async => _onWinning('player2'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      VisibilityWidget(
                        visibility: widget.match.players['player2']!
                            .checkStatus(PlayerStatus.connected),
                        child: const Icon(
                          Icons.wifi,
                          size: 16,
                        ),
                      ),
                      Text(
                        widget.match.players['player2']!.playerName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async => _onWinning('player1'),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    VisibilityWidget(
                        visibility: widget.match.players['player1']!
                            .checkStatus(PlayerStatus.connected),
                        child: const Icon(
                          Icons.wifi,
                          size: 16,
                        )),
                    Text(
                      widget.match.players['player1']!.playerName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onWinning(String playerId) async {
    WinningResult? result = await Navigator.pushNamed<WinningResult>(
        context, '/winning_result_create', arguments: {
      'players': widget.match.players.values.toList(),
      'winner': playerId
    });
    if (result == null) return;
    widget.match.setRoundResult(result);
    setState(() {});
  }
}
