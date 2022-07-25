import 'package:flutter/material.dart';

import '../firestore/token.dart';


class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _History();
}

class _History extends State<History> {
  final List<String> items = List<String>.generate(3, (i) => 'Item $i');
  final List<Map<String, String>> test = [
    {'テスト題名１': '1'},
    {'': ''}
  ];

  @override
  void initState() {
    super.initState();
    Future(() async {
      var result = await TokenFireStore.getHistory();
      print(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: Text(items[index]),
                trailing: Text('結果を見る'),
                title: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        'テスト',
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
