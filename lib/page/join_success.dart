import 'package:flutter/material.dart';

class JoinSuccess extends StatefulWidget {
  const JoinSuccess({Key? key});

  @override
  State<JoinSuccess> createState() => _JoinSuccessState();
}

class _JoinSuccessState extends State<JoinSuccess> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

    return Scaffold(
      appBar: AppBar(
        title: Text('参加する'),
      ),
      body: Column(
        children: <Widget>[Text('参加成功')],
      ),
    );
  }
}
