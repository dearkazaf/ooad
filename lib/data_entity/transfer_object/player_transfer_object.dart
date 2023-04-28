import 'package:json_annotation/json_annotation.dart';

import 'package:mahjong_cal/constant/enum_wind.dart';

part 'player_transfer_object.g.dart';

@JsonSerializable()
class PlayerTransferObject {
  final String id;
  final String playerName;
  final EnumWind wind;
  final int points;
  final int status;

  PlayerTransferObject(
      this.id, this.playerName, this.wind, this.points, this.status);

  factory PlayerTransferObject.fromJson(Map<String, dynamic> json) =>
      _$PlayerTransferObjectFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerTransferObjectToJson(this);
}
