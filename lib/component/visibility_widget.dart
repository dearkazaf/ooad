import 'package:flutter/material.dart';

class VisibilityWidget extends StatelessWidget {
  final bool visibility;
  final Widget child;
  final Widget? hider;

  const VisibilityWidget(
      {Key? key, required this.visibility, required this.child, this.hider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return visibility ? child : (hider == null ? Container() : hider!);
  }
}
