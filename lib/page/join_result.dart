import 'package:chusen_kun/const/object_name.dart';
import 'package:flutter/material.dart';

class JoinResult extends StatefulWidget {
  const JoinResult({Key? key});

  @override
  State<JoinResult> createState() => _JoinResultState();
}

class _JoinResultState extends State<JoinResult> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('抽選参加完了'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ObjectName.JOIN_SUCCESS,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            SizedBox(
              child: Image.asset('assets/shingou_machi.png'),
              width: 300,
            ),
            Text(ObjectName.PLS_WAIT),
          ],
        ),
      ),
    );
  }
}
