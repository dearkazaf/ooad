import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahjong_cal/component/button/richi_button.dart';
import 'package:mahjong_cal/constant/player_status.dart';
import 'package:mahjong_cal/constant/wind_translate_map.dart';

import 'package:mahjong_cal/modal/network/game_client.dart';
import 'package:mahjong_cal/component/text/player_wind_text.dart';
import 'package:mahjong_cal/data_entity/transfer_object/player_transfer_object.dart';
import 'package:mahjong_cal/data_entity/transfer_object/round_transfer_object.dart';

class RemoteScoreBoard extends StatefulWidget {
  final GameClient client;

  const RemoteScoreBoard({Key? key, required this.client}) : super(key: key);

  @override
  State<RemoteScoreBoard> createState() => _RemoteScoreBoardState();
}

class _RemoteScoreBoardState extends State<RemoteScoreBoard> {
  PlayerTransferObject? player;
  RoundTransferObject? round;
  List<PlayerTransferObject> opponents = [];

  @override
  void initState() {
    super.initState();
    widget.client.onUpdate = _onUpdate;
    widget.client.onDisconnect = _onDisconnect;
    _onUpdate();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  void dispose() {
    widget.client.disconnect();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  void _onUpdate() {
    String playerId = widget.client.selectedPlayerId;
    round = widget.client.transferMatch!.round;
    player = widget.client.transferMatch!.players[playerId];
    opponents = widget.client.transferMatch!.players.values
        .where((PlayerTransferObject obj) => obj.id != playerId)
        .toList();
    setState(() {});
  }

  void _onDisconnect() {
    Navigator.popUntil(context, ModalRoute.withName('/connectable_list'));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> opponentsWidget = [];
    for (int i = 0; i < opponents.length; i++) {
      PlayerTransferObject player = opponents[i];
      if (i == 0) {
        opponentsWidget.add(Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              border: Border.all(
                width: 1,
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    PlayerWindText(
                      wind: player.wind,
                      fontSize: 40,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(player.playerName),
                        Text(
                          player.points.toString(),
                          style: const TextStyle(
                            color: Color.fromRGBO(33, 150, 243, 1),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: RichiButton(
                      isRichi: (player.status & PlayerStatus.richi) != 0,
                      onClick: () {}),
                ),
              ],
            ),
          ),
        ));
      } else if (i == (opponents.length - 1)) {
        opponentsWidget.add(Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(
                width: 1,
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    PlayerWindText(
                      wind: player.wind,
                      fontSize: 40,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(player.playerName),
                        Text(
                          player.points.toString(),
                          style: const TextStyle(
                            color: Color.fromRGBO(33, 150, 243, 1),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: RichiButton(
                      isRichi: (player.status & PlayerStatus.richi) != 0,
                      onClick: () {}),
                ),
              ],
            ),
          ),
        ));
      } else {
        opponentsWidget.add(Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    PlayerWindText(
                      wind: player.wind,
                      fontSize: 40,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(player.playerName),
                        Text(
                          player.points.toString(),
                          style: const TextStyle(
                            color: Color.fromRGBO(33, 150, 243, 1),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: RichiButton(
                      isRichi: (player.status & PlayerStatus.richi) != 0,
                      onClick: () {}),
                ),
              ],
            ),
          ),
        ));
      }
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${windTranslate[round!.gameWind]}${round!.gameCount}局',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '${round!.dealerCounter}本場',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: opponentsWidget,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.7,
              child: RichiButton(
                  isRichi: (player!.status & PlayerStatus.richi) != 0,
                  onClick: () => widget.client.clamRichi()),
            ),
            Text(
              player!.points.toString(),
              style: const TextStyle(
                color: Color.fromRGBO(33, 150, 243, 1),
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PlayerWindText(
                  wind: player!.wind,
                  fontSize: 40,
                ),
                const SizedBox(
                  width: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(player!.playerName),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
