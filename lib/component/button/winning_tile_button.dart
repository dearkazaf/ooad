import 'package:flutter/material.dart';

class WinningTileButton extends StatelessWidget {
  final List<String> text;
  final List<String> selectedIndex;
  final ValueChanged<String> onSelect;

  const WinningTileButton(
      {Key? key,
      required this.selectedIndex,
      required this.text,
      required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: text.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return OutlinedButton(
          onPressed: () => onSelect(text[index]),
          style: selectedIndex.contains(text[index])
              ? OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
                )
              : OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.transparent,
                ),
          child: Text(
            text[index],
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
