import 'package:flutter/material.dart';
import 'page/create_lottery.dart';
import 'page/join_lottery.dart';
import 'firestore/lottery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '抽選くん'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              style: ElevatedButton.styleFrom(
                primary: Colors.grey
              ),
              onPressed: () async {
                // 遷移するときの処理を書く
                print('抽選を作成する');
                await LotteryFireStore.addLottery();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateLottery()),
                );
              },
              child: const Text('抽選を作成する'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              onPressed: () {
                // 遷移するときの処理を書く
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinLottery()),
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
