import 'package:mahjong_cal/constant/enum_wind.dart';

const Map<EnumWind, EnumWind> threePlayerRoundWindTransfer = {
  EnumWind.east: EnumWind.south,
  EnumWind.south: EnumWind.west,
  EnumWind.west: EnumWind.east
};

const Map<EnumWind, EnumWind> fourPlayerRoundWindTransfer = {
  EnumWind.east: EnumWind.south,
  EnumWind.south: EnumWind.west,
  EnumWind.west: EnumWind.north,
  EnumWind.north: EnumWind.east
};

const Map<EnumWind, EnumWind> threePlayerWindTransfer = {
  EnumWind.east: EnumWind.west,
  EnumWind.south: EnumWind.east,
  EnumWind.west: EnumWind.south
};

const Map<EnumWind, EnumWind> fourPlayerWindTransfer = {
  EnumWind.east: EnumWind.north,
  EnumWind.south: EnumWind.east,
  EnumWind.west: EnumWind.south,
  EnumWind.north: EnumWind.west
};
