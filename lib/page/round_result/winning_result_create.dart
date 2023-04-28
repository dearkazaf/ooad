import 'dart:math';
import 'package:flutter/material.dart';

import 'package:mahjong_cal/modal/player.dart';
import 'package:mahjong_cal/constant/enum_win_type.dart';
import 'package:mahjong_cal/component/visibility_widget.dart';
import 'package:mahjong_cal/component/input/number_input.dart';
import 'package:mahjong_cal/component/button/winning_tile_button.dart';
import 'package:mahjong_cal/component/button/tab_bar_option_button.dart';
import 'package:mahjong_cal/data_entity/round_result/winning_result.dart';

class WinningResultCreate extends StatefulWidget {
  final List<Player> players;
  final String winner;

  const WinningResultCreate(
      {Key? key, required this.players, required this.winner})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _WinningResultCreate();
}

class _WinningResultCreate extends State<WinningResultCreate> {
  EnumWinType winType = EnumWinType.selfDraw;
  int fu = 20;
  Map<int, List<String>> tile = {};
  int yakuhaiCount = 0;
  int doraCount = 0;
  String? chucker;

  @override
  Widget build(BuildContext context) {
    List<String> index = [];
    List<String> option = [];
    for (Player player in widget.players) {
      index.add(player.id);
      option.add(player.playerName);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('和'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              '確認',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              List<String> resultTile = [];
              int han = 0;
              resultTile.addAll(tile[1] ?? []);
              han += (tile[1] ?? []).length;
              if (yakuhaiCount != 0) {
                resultTile.add('役牌$yakuhaiCount');
                han += yakuhaiCount;
              }
              if (doraCount != 0) {
                resultTile.add('寶牌$doraCount');
                han += doraCount;
              }
              resultTile.addAll(tile[2] ?? []);
              han += ((tile[2] ?? []).length * 2);
              resultTile.addAll(tile[3] ?? []);
              han += ((tile[3] ?? []).length * 3);
              resultTile.addAll(tile[6] ?? []);
              han += ((tile[6] ?? []).length * 6);
              resultTile.addAll(tile[8] ?? []);
              han += ((tile[8] ?? []).length * 8);
              resultTile.addAll(tile[13] ?? []);
              han += ((tile[13] ?? []).length * 13);
              Navigator.pop(
                  context,
                  WinningResult(widget.winner, winType, resultTile, han, fu,
                      chucker: chucker));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBarOptionButton<EnumWinType>(
                selectedIndex: winType,
                index: const [EnumWinType.selfDraw, EnumWinType.ron],
                text: const ['自摸', '榮和'],
                onSelect: (EnumWinType select) {
                  setState(() {
                    winType = select;
                  });
                },
              ),
              VisibilityWidget(
                visibility: winType == EnumWinType.ron,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '放槍',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    TabBarOptionButton<String>(
                      selectedIndex: chucker,
                      index: index,
                      text: option,
                      onSelect: (String select) {
                        setState(() {
                          chucker = select;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Text(
                '符',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              NumberInput(
                number: fu,
                onAdd: () {
                  setState(() => fu += 2);
                },
                onMinus: () {
                  setState(() => fu = max(20, fu - 2));
                },
              ),
              const Text(
                '牌型',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(33, 150, 243, 1),
                      ),
                      child: const Text(
                        '一翻',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    WinningTileButton(
                      selectedIndex: tile[1] ?? [],
                      text: const [
                        '立直',
                        '一發',
                        '門前清自摸胡',
                        '斷么九',
                        '平胡',
                        '一盃口',
                        '嶺上開花',
                        '槍槓',
                        '海底撈月',
                        '河底撈魚'
                      ],
                      onSelect: (String select) {
                        List<String> list = tile[1] ?? [];
                        if (list.contains(select)) {
                          list.remove(select);
                        } else {
                          list.add(select);
                        }
                        setState(() => tile[1] = list);
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '役牌',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              NumberInput(
                                number: yakuhaiCount,
                                onAdd: () {
                                  setState(() => yakuhaiCount += 1);
                                },
                                onMinus: () {
                                  setState(() =>
                                      yakuhaiCount = max(0, yakuhaiCount - 1));
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '寶牌',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              NumberInput(
                                number: doraCount,
                                onAdd: () {
                                  setState(() => doraCount += 1);
                                },
                                onMinus: () {
                                  setState(
                                      () => doraCount = max(0, doraCount - 1));
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(33, 150, 243, 1),
                      ),
                      child: const Text(
                        '二翻',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    WinningTileButton(
                      selectedIndex: tile[2] ?? [],
                      text: const [
                        '三色同順',
                        '三色同刻',
                        '一氣通貫',
                        '對對胡',
                        '三暗刻',
                        '三槓子',
                        '七對子',
                        '混全帶么九',
                        '混老頭',
                        '小三元',
                        '雙立直'
                      ],
                      onSelect: (String select) {
                        List<String> list = tile[2] ?? [];
                        if (list.contains(select)) {
                          list.remove(select);
                        } else {
                          list.add(select);
                        }
                        setState(() => tile[2] = list);
                      },
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(33, 150, 243, 1),
                      ),
                      child: const Text(
                        '三翻',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    WinningTileButton(
                      selectedIndex: tile[3] ?? [],
                      text: const ['混一色', '純全帶么九', '二盃口'],
                      onSelect: (String select) {
                        List<String> list = tile[3] ?? [];
                        if (list.contains(select)) {
                          list.remove(select);
                        } else {
                          list.add(select);
                        }
                        setState(() => tile[3] = list);
                      },
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(33, 150, 243, 1),
                      ),
                      child: const Text(
                        '六翻',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    WinningTileButton(
                      selectedIndex: tile[6] ?? [],
                      text: const ['清一色'],
                      onSelect: (String select) {
                        List<String> list = tile[6] ?? [];
                        if (list.contains(select)) {
                          list.remove(select);
                        } else {
                          list.add(select);
                        }
                        setState(() => tile[6] = list);
                      },
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(33, 150, 243, 1),
                      ),
                      child: const Text(
                        '役滿',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    WinningTileButton(
                      selectedIndex: tile[13] ?? [],
                      text: const [
                        '國士無雙',
                        '大三元',
                        '四暗刻',
                        '字一色',
                        '綠一色',
                        '小四喜',
                        '大四喜',
                        '清老頭',
                        '九蓮寶燈',
                        '純正九蓮寶燈',
                        '四槓子',
                        '天胡',
                        '地胡'
                      ],
                      onSelect: (String select) {
                        List<String> list = tile[13] ?? [];
                        if (list.contains(select)) {
                          list.remove(select);
                        } else {
                          list.add(select);
                        }
                        setState(() => tile[13] = list);
                      },
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(33, 150, 243, 1),
                      ),
                      child: const Text(
                        '流局滿貫',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    WinningTileButton(
                      selectedIndex: tile[8] ?? [],
                      text: const [
                        '流局滿貫',
                      ],
                      onSelect: (String select) {
                        List<String> list = tile[8] ?? [];
                        if (list.contains(select)) {
                          list.remove(select);
                        } else {
                          list.add(select);
                        }
                        setState(() => tile[8] = list);
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
