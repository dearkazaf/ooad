import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mahjong_cal/constant/constant.dart';
import 'package:mahjong_cal/constant/request_type.dart';
import 'package:mahjong_cal/data_entity/request_object.dart';
import 'package:mahjong_cal/data_entity/transfer_object/match_transfer_object.dart';

class GameClient {
  late Socket _socket;
  late String _selectedPlayerId;
  MatchTransferObject? _transferMatch;
  VoidCallback? _onDisconnect;
  VoidCallback? _onUpdate;

  String get selectedPlayerId => _selectedPlayerId;
  MatchTransferObject? get transferMatch => _transferMatch;

  set onDisconnect(VoidCallback callback) => _onDisconnect = callback;
  set onUpdate(VoidCallback callback) => _onUpdate = callback;

  Future<void> connect(String ip, String playerId) async {
    _selectedPlayerId = playerId;
    _socket = await Socket.connect(ip, Constant.servicePort);
    Completer completer = Completer();
    _socket.listen(
        (Uint8List event) => _onRequest(completer, String.fromCharCodes(event)),
        onDone: () {
      _socket.destroy();
      (_onDisconnect ?? () {})();
    });
    _socket.add(
        jsonEncode(RequestObject(RequestType.connect, data: playerId).toJson())
            .codeUnits);
    return await completer.future;
  }

  void disconnect() {
    _socket.add(jsonEncode(
            RequestObject(RequestType.disconnect, data: selectedPlayerId)
                .toJson())
        .codeUnits);
    _socket.destroy();
  }

  void clamRichi() {
    _socket.add(jsonEncode(
            RequestObject(RequestType.richi, data: selectedPlayerId).toJson())
        .codeUnits);
  }

  void _onRequest(Completer completer, String request) {
    _transferMatch = MatchTransferObject.fromJson(jsonDecode(request));
    if (!completer.isCompleted) completer.complete();
    (_onUpdate ?? () {})();
  }
}
