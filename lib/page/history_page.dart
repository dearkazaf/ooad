import 'package:flutter/material.dart';
import 'package:mahjong_cal/modal/history.dart';
import 'package:mahjong_cal/data_entity/record/match_record.dart';
import 'package:mahjong_cal/data_entity/record/player_record.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final History history = History();

  @override
  void initState() {
    super.initState();
    history.loadFile().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('紀錄'),
      ),
      body: ListView.builder(
        itemCount: history.histories.length,
        itemBuilder: (BuildContext context, int index) {
          MatchRecord record = history.histories[index];
          List<Widget> names = [];
          for (PlayerRecord player in record.players.values) {
            names.add(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.playerName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    player.points.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(33, 150, 243, 1),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: names,
            ),
          );
        },
      ),
    );
  }
}
