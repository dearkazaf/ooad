import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mahjong_cal/data_entity/request_object.dart';

class SocketClient {
  static Future<String?> request(
      String ip, int port, RequestObject request) async {
    Completer completer = Completer<String?>();

    Socket socket = await Socket.connect(ip, port);
    socket.listen((Uint8List event) {
      completer.complete(String.fromCharCodes(event));
    }, onError: (Object error) {
      completer.complete(null);
    });
    socket.add(jsonEncode(request.toJson()).codeUnits);

    return await completer.future;
  }
}
