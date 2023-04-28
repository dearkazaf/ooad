import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mahjong_cal/modal/match.dart';
import 'package:mahjong_cal/modal/player.dart';
import 'package:mahjong_cal/constant/constant.dart';
import 'package:mahjong_cal/constant/request_type.dart';
import 'package:mahjong_cal/constant/player_status.dart';
import 'package:mahjong_cal/data_entity/server_info.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:mahjong_cal/data_entity/request_object.dart';

class GameServer {
  Match match;
  ServerSocket? server;
  String ip = '';
  Map<String, Socket> sockets = {};
  Map<String, String> connectedClient = {};

  GameServer(this.match);

  Future<void> start() async {
    try {
      match.onUpdate = _onMatchUpdate;
      NetworkInfo info = NetworkInfo();
      ip = (await info.getWifiIP())!;
      server = await ServerSocket.bind('0.0.0.0', Constant.servicePort);
      server!.listen(_onConnect);
    } catch (_) {}
  }

  Future<void> stop() async {
    await server!.close();
    server = null;
  }

  void _onConnect(Socket socket) {
    String address = socket.remoteAddress.address;
    if (sockets.containsKey(address)) {
      sockets[address]!.close();
    }
    sockets[address] = socket;
    socket.listen(
        (Uint8List data) => _onRequest(address, String.fromCharCodes(data)),
        onDone: () {
      sockets[address]!.destroy();
      sockets.remove(address);
      if (connectedClient[address] != null) {
        match.playerDisconnect(connectedClient[address]!);
        connectedClient.remove(address);
      }
    });
  }

  void _onRequest(String address, String request) {
    RequestObject req = RequestObject.fromJson(jsonDecode(request));
    if (sockets[address] == null) return;
    switch (req.command) {
      case RequestType.getInfo:
        Map<String, String> playerNames = {};
        for (Player player in match.players.values) {
          playerNames[player.id] = player.playerName;
        }
        sockets[address]!
            .add(jsonEncode(ServerInfo(ip, playerNames).toJson()).codeUnits);
        break;
      case RequestType.connect:
        String playerId = req.data!;
        match.playerConnect(playerId);
        connectedClient[address] = playerId;
        sockets[address]!
            .add(jsonEncode(match.toTransferObject().toJson()).codeUnits);
        break;
      case RequestType.disconnect:
        sockets[address]!.destroy();
        sockets.remove(address);
        if (connectedClient[address] != null) {
          match.playerDisconnect(connectedClient[address]!);
          connectedClient.remove(address);
        }
        break;
      case RequestType.richi:
        String playerId = req.data!;
        match.clamRichi(playerId);
        break;
    }
  }

  void _onMatchUpdate() {
    List<int> encodedMatch =
        jsonEncode(match.toTransferObject().toJson()).codeUnits;
    for (String address in connectedClient.keys) {
      if (sockets[address] == null) continue;
      sockets[address]!.add(encodedMatch);
    }
  }
}
