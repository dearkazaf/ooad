import 'package:flutter/material.dart';

class RoundResultButton extends StatelessWidget {
  final bool settleMode;
  final VoidCallback onSettle;
  final VoidCallback onDraw;
  final VoidCallback onDrawInProgress;

  const RoundResultButton(
      {Key? key,
      required this.settleMode,
      required this.onSettle,
      required this.onDraw,
      required this.onDrawInProgress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (settleMode) {
      return Center(
        child: OutlinedButton(
          onPressed: () => onSettle(),
          style: OutlinedButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            '繼續',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () => onDraw(),
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
            ),
            child: const Text(
              '荒牌流局',
              style: TextStyle(color: Colors.white),
            ),
          ),
          OutlinedButton(
            onPressed: () => onDrawInProgress(),
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
            child: const Text(
              '途中流局',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    }
  }
}
