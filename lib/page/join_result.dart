import 'package:chusen_kun/const/object_name.dart';
import 'package:flutter/material.dart';

class JoinResult extends StatefulWidget {
  const JoinResult({Key? key});

  @override
  State<JoinResult> createState() => _JoinResultState();
}

class _JoinResultState extends State<JoinResult> {
  bool result = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO: 結果を取得し、画面表示内容を分ける
    setState(() {
      this.result = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('抽選結果'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            result
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
