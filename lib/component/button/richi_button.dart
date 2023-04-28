import 'package:flutter/material.dart';

class RichiButton extends StatelessWidget {
  final VoidCallback onClick;
  final bool isRichi;
  const RichiButton({Key? key, required this.isRichi, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isRichi) {
      return OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: const Text(
          '●',
          style: TextStyle(
            fontSize: 8,
            color: Colors.red,
          ),
        ),
      );
    }
    return OutlinedButton(
      onPressed: () => onClick(),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Container(),
    );
  }
}
