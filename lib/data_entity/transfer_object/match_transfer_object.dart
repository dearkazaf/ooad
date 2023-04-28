import 'package:json_annotation/json_annotation.dart';

import 'package:mahjong_cal/data_entity/transfer_object/player_transfer_object.dart';
import 'package:mahjong_cal/data_entity/transfer_object/round_transfer_object.dart';

part 'match_transfer_object.g.dart';

@JsonSerializable(explicitToJson: true)
class MatchTransferObject {
  Map<String, PlayerTransferObject> players;
  RoundTransferObject round;

  MatchTransferObject(this.players, this.round);

  factory MatchTransferObject.fromJson(Map<String, dynamic> json) =>
      _$MatchTransferObjectFromJson(json);
  Map<String, dynamic> toJson() => _$MatchTransferObjectToJson(this);
}
