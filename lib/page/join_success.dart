import 'package:chusen_kun/const/object_name.dart';
import 'package:flutter/material.dart';

class JoinSuccess extends StatefulWidget {
  const JoinSuccess({Key? key});

  @override
  State<JoinSuccess> createState() => _JoinSuccessState();
}

class _JoinSuccessState extends State<JoinSuccess> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('参加完了'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
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
