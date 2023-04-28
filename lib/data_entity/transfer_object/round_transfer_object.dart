import 'package:json_annotation/json_annotation.dart';

import 'package:mahjong_cal/constant/enum_wind.dart';

part 'round_transfer_object.g.dart';

@JsonSerializable()
class RoundTransferObject {
  final EnumWind gameWind;
  final int gameCount;
  final int dealerCounter;

  RoundTransferObject(this.gameWind, this.gameCount, this.dealerCounter);

  factory RoundTransferObject.fromJson(Map<String, dynamic> json) =>
      _$RoundTransferObjectFromJson(json);
  Map<String, dynamic> toJson() => _$RoundTransferObjectToJson(this);
}
