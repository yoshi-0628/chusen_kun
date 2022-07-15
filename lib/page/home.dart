import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../firestore/lottery.dart';
import '../model/lottery.dart';
import '../theme/dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  String argument = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Image.asset('assets/party_bingo_taikai_man.png'),
              width: 300,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.grey),
              onPressed: () async {
                print('抽選を作成する');
                Lottery newLottery = Lottery(
                  createdTime: Timestamp.now(),
                );
                try {
                  DocumentReference result =
                      await LotteryFireStore.addLottery(newLottery);
                  Navigator.pushNamed(context, '/create', arguments: result.id);
                } catch (e) {
                  dialog(context,'エラーが発生しました', '抽選の作成に失敗しました。');
                }
              },
              child: const Text('抽選を作成する'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              onPressed: () {
                // 遷移するときの処理を書く
                Navigator.pushNamed(
                  context,
                  '/join',
                );
                print('抽選に参加する');
              },
              child: const Text('抽選に参加する'),
            ),
          ],
        ),
      ),
    );
  }
}
