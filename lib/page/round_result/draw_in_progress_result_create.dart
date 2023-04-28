import 'package:flutter/material.dart';
import 'package:mahjong_cal/component/button/tab_bar_option_button.dart';

class DrawInProgressResultCreate extends StatefulWidget {
  const DrawInProgressResultCreate({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawInProgressResultCreate();
}

class _DrawInProgressResultCreate extends State<DrawInProgressResultCreate> {
  String drawType = "九種九牌";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('荒牌流局'),
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
              Navigator.pop(context, drawType);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '流局類型',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            TabBarOptionButton<String>(
              selectedIndex: drawType,
              index: const ['九種九牌', '四風連打', '四槓散了', '四家立直', '三家和了'],
              text: const ['九種九牌', '四風連打', '四槓散了', '四家立直', '三家和了'],
              onSelect: (String select) {
                setState(() {
                  drawType = select;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
