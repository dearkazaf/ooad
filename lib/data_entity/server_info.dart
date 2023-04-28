import 'package:json_annotation/json_annotation.dart';

part 'server_info.g.dart';

@JsonSerializable()
class ServerInfo {
  String ip;
  Map<String, String> playerNames;

  ServerInfo(this.ip, this.playerNames);

  factory ServerInfo.fromJson(Map<String, dynamic> json) =>
      _$ServerInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ServerInfoToJson(this);
}
