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
  String token = '';

  String getTitle(DocumentSnapshot snap) {
    try {
      return snap.get('title');
    } catch (e) {
      return 'タイトル未設定';
    }
  }

  bool isCreater(DocumentSnapshot snap) {
    try {
      return snap.get('creater_uid') == token;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      var uids = await TokenFireStore.getHistory();
      List<DocumentSnapshot> tmp = await LotteryFireStore.getLottery(uids);
      String? _token = await TokenFireStore.messaging.getToken();
      setState(() {
        historyList = tmp;
        token = _token!;
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
              leading: isCreater(historyList[index]) ? Icon(Icons.edit) : Text(''),
              trailing: isCreater(historyList[index]) ? Text('') : Text('結果を見る'),
              title: Text(getTitle(historyList[index])),
              onTap: () {
                if (isCreater(historyList[index])) {
                  if(historyList[index].get('end_flg') == '1') {
                    Navigator.pushNamed(context, '/endLottery');
                  } else {
                    Navigator.pushNamed(context, '/edit', arguments: {
                      'uid': historyList[index].id,
                      'title': historyList[index].get('title'),
                      'winner': historyList[index].get('winners_num'),
                    });
                  }
                } else {
                  Navigator.pushNamed(context, '/joinResult');
                }
              },
            );
          },
        ),
      ),
    );
  }
}
