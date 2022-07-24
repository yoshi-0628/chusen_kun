import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _History();
}

class _History extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          '遷移後oooo',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
