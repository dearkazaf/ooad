import 'package:flutter/material.dart';

class MultiSelectTabBarOptionButton<T> extends StatelessWidget {
  final List<T> selectedIndex;
  final List<T> index;
  final List<String> text;
  final ValueChanged<T> onSelect;

  const MultiSelectTabBarOptionButton(
      {Key? key,
      required this.selectedIndex,
      required this.index,
      required this.text,
      required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];
    for (int i = 0; i < index.length; i++) {
      if (i == 0) {
        buttons.add(
          Expanded(
            child: OutlinedButton(
              onPressed: () => onSelect(index[i]),
              style: selectedIndex.contains(index[i])
                  ? OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                    )
                  : OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                    ),
              child: Text(
                text[i],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      } else if (i == index.length - 1) {
        buttons.add(
          Expanded(
            child: OutlinedButton(
              onPressed: () => onSelect(index[i]),
              style: selectedIndex.contains(index[i])
                  ? OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                    )
                  : OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                    ),
              child: Text(
                text[i],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      } else {
        buttons.add(
          Expanded(
            child: OutlinedButton(
              onPressed: () => onSelect(index[i]),
              style: selectedIndex.contains(index[i])
                  ? OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    )
                  : OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
              child: Text(
                text[i],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons,
    );
  }
}
