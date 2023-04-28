import 'dart:async';
import 'dart:convert';

import 'package:mahjong_cal/constant/constant.dart';
import 'package:mahjong_cal/constant/request_type.dart';
import 'package:mahjong_cal/data_entity/request_object.dart';
import 'package:mahjong_cal/data_entity/server_info.dart';
import 'package:mahjong_cal/utility/network_scanner.dart';
import 'package:mahjong_cal/utility/socket_client.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:mahjong_cal/data_entity/network_address.dart';

class ServerFinder {
  static Stream<NetworkAddress> find() async* {
    NetworkInfo info = NetworkInfo();
    String? ip = await info.getWifiIP();
    if (ip == null) return;
    String subnet = ip.substring(0, ip.lastIndexOf('.'));

    Stream<NetworkAddress> stream =
        NetworkScanner.scanAsync(subnet, Constant.servicePort);
    yield* stream;
  }

  static Future<ServerInfo?> getServerInfo(String ip) async {
    String? res = await SocketClient.request(
        ip, Constant.servicePort, RequestObject(RequestType.getInfo));
    if (res == null) return null;
    ServerInfo info = ServerInfo.fromJson(jsonDecode(res));
    info.ip = ip;
    return info;
  }
}
