import 'package:chusen_kun/firestore/lottery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firestore/token.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _History();
}

class _History extends State<History> {
  final List<String> items = List<String>.generate(3, (i) => 'Item $i');
  List<DocumentSnapshot> historyList = <DocumentSnapshot>[];

  String getTitle(DocumentSnapshot snap) {
    try {
      return snap.get('title');
    } catch (e) {
      return 'タイトル未設定';
    }
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      var uids = await TokenFireStore.getHistory();
      List<DocumentSnapshot> tmp = await LotteryFireStore.getLottery(uids);
      setState(() {
        historyList = tmp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView.builder(
          itemCount: historyList.length,
          itemBuilder: (
            context,
            index,
          ) {
            return ListTile(
              leading: Icon(Icons.edit),
              trailing: Text('結果を見る'),
              title: Text(getTitle(historyList[index])),
              onTap: () {
                Navigator.pushNamed(context, '/joinResult');
              },
            );
          },
        ),
      ),
    );
  }
}
