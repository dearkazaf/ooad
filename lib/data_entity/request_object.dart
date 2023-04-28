import 'package:json_annotation/json_annotation.dart';

import 'package:mahjong_cal/constant/request_type.dart';

part 'request_object.g.dart';

@JsonSerializable()
class RequestObject {
  RequestType command;
  String? data;

  RequestObject(this.command, {this.data});

  factory RequestObject.fromJson(Map<String, dynamic> json) =>
      _$RequestObjectFromJson(json);
  Map<String, dynamic> toJson() => _$RequestObjectToJson(this);
}
