import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class CreateLottery extends StatelessWidget {
  const CreateLottery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('作成する'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: "1234567890",
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}

