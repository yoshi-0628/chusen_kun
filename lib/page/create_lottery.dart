import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../firestore/lottery.dart';

class CreateLottery extends StatefulWidget {
  const CreateLottery({Key? key}) : super(key: key);

  @override
  State<CreateLottery> createState() => _CreateLottery();
}



class _CreateLottery extends State<CreateLottery> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LotteryFireStore.getLottery();
  }
  @override
  Widget build(BuildContext context) {
    int join_num = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('作成する'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  print('refresh');
                },
                icon: Icon(Icons.refresh)),
            QrImage(
              data: "1234567890",
              version: QrVersions.auto,
              size: 200.0,
            ),
            ElevatedButton(
                onPressed: () {
                  print('抽選開始');
                },
                child: const Text('抽選を開始する')),
            Text('参加人数 $join_num'),
          ],
        ),
      ),
    );
  }
}
