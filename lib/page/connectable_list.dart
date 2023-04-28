import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mahjong_cal/constant/constant.dart';

import 'package:mahjong_cal/data_entity/server_info.dart';
import 'package:mahjong_cal/modal/network/server_finder.dart';
import 'package:mahjong_cal/data_entity/network_address.dart';
import 'package:mahjong_cal/component/text/connectable_server_text.dart';
import 'package:mahjong_cal/component/dialog/platform_input_dialog.dart';
import 'package:mahjong_cal/utility/socket_client.dart';

class ConnectableList extends StatefulWidget {
  const ConnectableList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectableList();
}

class _ConnectableList extends State<ConnectableList> {
  List<NetworkAddress> addresses = [];
  Map<String, ServerInfo> serverInfos = {};

  @override
  void initState() {
    super.initState();

    ServerFinder.find()
        .where((NetworkAddress address) => address.exists)
        .listen((NetworkAddress address) async {
      addresses.add(address);
      ServerInfo? info = await ServerFinder.getServerInfo(address.ip);
      if (info != null) serverInfos[address.ip] = info;
      setState(() {});
    });
  }

  Future<void> _onConnectWithMissingServerInfo(
      BuildContext context, String ip) async {
    EasyLoading.show();
    ServerInfo? info = await ServerFinder.getServerInfo(ip);
    if (info == null) {
      EasyLoading.showError('Connection fail');
      return;
    }
    EasyLoading.dismiss();
    Navigator.pushNamed(context, '/player_connect', arguments: info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('連線'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: addresses.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == addresses.length) {
            return GestureDetector(
              onTap: () async {
                String? ip = await _onMenuInputIp();
                if (ip == null) return;
                _onConnectWithMissingServerInfo(context, ip);
              },
              child: const Center(
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          }
          return GestureDetector(
            onTap: () async {
              ServerInfo? info = serverInfos[addresses[index].ip];
              if (info == null) {
                _onConnectWithMissingServerInfo(context, addresses[index].ip);
                return;
              }
              Navigator.pushNamed(context, '/player_connect', arguments: info);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    width: 1,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.12),
                  ),
                ),
              ),
              child: ConnectableServerText(
                ip: addresses[index].ip,
                info: serverInfos[addresses[index].ip],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String?> _onMenuInputIp() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return PlatformInputDialog(
          title: const Text(
            'ip',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          okText: '確認',
          onInputSubmit: (String text) async {
            Navigator.pop(context, text);
          },
        );
      },
    );
  }
}
