import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../firestore/lottery.dart';

class CreateLottery extends StatefulWidget {
  const CreateLottery({Key? key});
  @override
  State<CreateLottery> createState() => _CreateLottery();
}



class _CreateLottery extends State<CreateLottery> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   LotteryFireStore.getLottery();
  // }
  @override
  Widget build(BuildContext context) {
    String uid = ModalRoute.of(context)?.settings.arguments as String;
    int join_num = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(uid),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'タイトルを入力してください',
                ),
                onFieldSubmitted: (String value) {
                  print('submit: $value');
                },
              ),
            ),
            IconButton(
                onPressed: () {
                  print('refresh');
                },
                icon: Icon(Icons.refresh)),
            QrImage(
              data: uid,
              version: QrVersions.auto,
              size: 200.0,
            ),
            ElevatedButton(
                onPressed: () {
                  print(uid);
                },
                child: const Text('抽選を開始する')),
            Text('参加人数 $join_num'),
          ],
        ),
      ),
    );
  }
}
