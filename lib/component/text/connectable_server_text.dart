import 'package:flutter/material.dart';
import 'package:mahjong_cal/data_entity/server_info.dart';

class ConnectableServerText extends StatelessWidget {
  final String ip;
  final ServerInfo? info;

  const ConnectableServerText({Key? key, required this.ip, this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> names = [];
    if (info != null) {
      for (String playerName in info!.playerNames.values) {
        names.add(Text(
          playerName,
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(33, 150, 243, 1),
          ),
        ));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ip,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 4,
        ),
        info == null
            ? const Text(
                'error',
                style: TextStyle(color: Colors.red),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: names,
              ),
      ],
    );
  }
}
