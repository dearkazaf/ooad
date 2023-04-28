import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PlatformInputDialog extends StatelessWidget {
  final String okText;
  final Widget? title;
  final String cancelText;
  final int? maxLength;
  final ValueChanged<String> onInputSubmit;
  final TextEditingController _textEditingController;

  PlatformInputDialog(
      {Key? key,
      required this.onInputSubmit,
      this.okText = '確認',
      this.cancelText = '取消',
      this.maxLength,
      this.title,
      String? initText})
      : _textEditingController = TextEditingController(text: initText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AlertDialog(
        title: title,
        content: TextField(
          style: const TextStyle(color: Colors.white),
          controller: _textEditingController,
          maxLength: maxLength,
          decoration: const InputDecoration(counterText: ''),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              cancelText,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(
              okText,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              onInputSubmit(_textEditingController.text);
              Navigator.pop(context);
            },
          )
        ],
      );
    } else {
      return CupertinoAlertDialog(
        title: title,
        content: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: CupertinoTextField(
            style: const TextStyle(color: Colors.white),
            controller: _textEditingController,
            maxLength: maxLength,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              cancelText,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(
              okText,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              onInputSubmit(_textEditingController.text);
              Navigator.pop(context);
            },
          )
        ],
      );
    }
  }
}
