// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestObject _$RequestObjectFromJson(Map<String, dynamic> json) =>
    RequestObject(
      $enumDecode(_$RequestTypeEnumMap, json['command']),
      data: json['data'] as String?,
    );

Map<String, dynamic> _$RequestObjectToJson(RequestObject instance) =>
    <String, dynamic>{
      'command': _$RequestTypeEnumMap[instance.command],
      'data': instance.data,
    };

const _$RequestTypeEnumMap = {
  RequestType.getInfo: 'getInfo',
  RequestType.connect: 'connect',
  RequestType.disconnect: 'disconnect',
  RequestType.richi: 'richi',
};
