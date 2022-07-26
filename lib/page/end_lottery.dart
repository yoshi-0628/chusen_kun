import 'package:flutter/material.dart';

class EndLottery extends StatefulWidget {
  const EndLottery({Key? key}) : super(key: key);

  @override
  State<EndLottery> createState() => _EndLottery();
}

class _EndLottery extends State<EndLottery> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('抽選終了'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ご利用ありがとうございました。'),
            SizedBox(
              child: Image.asset('assets/text_kansya.png'),
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
