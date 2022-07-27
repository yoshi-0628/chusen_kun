import 'package:chusen_kun/const/object_name.dart';
import 'package:chusen_kun/firestore/lottery.dart';
import 'package:flutter/material.dart';

class JoinResult extends StatefulWidget {
  const JoinResult({Key? key});

  @override
  State<JoinResult> createState() => _JoinResultState();
}

class _JoinResultState extends State<JoinResult> {
  bool _result = false;
  String _uid = '';

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    setState(() {
      _uid = arguments['uid'];
    });
    Future(() async {
      bool isWinner = await LotteryFireStore.isWinner(arguments['uid']);
      setState(() {
        _result = isWinner;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('抽選結果'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _result
                ? Column(
                    children: [
                      SizedBox(
                        child: Image.asset('assets/pose_win_boy.png'),
                        width: 300,
                      ),
                      Text('おめでとう')
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        child: Image.asset('assets/pose_lose_boy.png'),
                        width: 300,
                      ),
                      Text('残念')
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
