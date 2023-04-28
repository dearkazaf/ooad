import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  final int number;
  final VoidCallback onAdd;
  final VoidCallback onMinus;
  const NumberInput(
      {Key? key,
      required this.number,
      required this.onAdd,
      required this.onMinus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: () => onMinus(),
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
            '-',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  width: 1,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              number.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () => onAdd(),
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
            '+',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
