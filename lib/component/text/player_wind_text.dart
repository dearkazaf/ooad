import 'package:flutter/material.dart';

import 'package:mahjong_cal/constant/enum_wind.dart';
import 'package:mahjong_cal/constant/wind_translate_map.dart';

class PlayerWindText extends StatelessWidget {
  final EnumWind wind;
  final double fontSize;

  const PlayerWindText({Key? key, required this.wind, this.fontSize = 28})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      windTranslate[wind]!,
      style: TextStyle(
        fontSize: fontSize,
        color: wind == EnumWind.east ? Colors.red : Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
