// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_transfer_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchTransferObject _$MatchTransferObjectFromJson(Map<String, dynamic> json) =>
    MatchTransferObject(
      (json['players'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, PlayerTransferObject.fromJson(e as Map<String, dynamic>)),
      ),
      RoundTransferObject.fromJson(json['round'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MatchTransferObjectToJson(
        MatchTransferObject instance) =>
    <String, dynamic>{
      'players': instance.players.map((k, e) => MapEntry(k, e.toJson())),
      'round': instance.round.toJson(),
    };
