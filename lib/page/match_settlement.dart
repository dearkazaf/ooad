import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mahjong_cal/modal/history.dart';
import 'package:mahjong_cal/modal/match.dart';
import 'package:mahjong_cal/modal/player.dart';

class MatchSettlement extends StatelessWidget {
  final Match match;
  const MatchSettlement({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Player> players = match.players.values.toList();
    players.sort((Player p1, Player p2) => p2.points.compareTo(p1.points));
    List<Widget> result = [];
    for (int i = 0; i < players.length; i++) {
      result.add(
        Container(
          width: 200,
          margin: EdgeInsets.only(left: i * 30, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(33, 150, 243, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: Text(
                    players[i].playerName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: Text(
                  players[i].points.toString(),
                  style: const TextStyle(
                    color: Color.fromRGBO(33, 150, 243, 1),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('結算'),
          leading: null,
          actions: [
            TextButton(
              child: const Text(
                "存檔",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () async {
                EasyLoading.show();
                History history = History();
                await history.loadFile();
                await history.addRecord(match.toRecord());
                EasyLoading.showSuccess("存檔成功");
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: result,
          ),
        ),
      ),
    );
  }
}
