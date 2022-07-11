import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Future<void> dialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('エラー'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('抽選の作成に失敗しました'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('閉じる'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

