import 'package:chusen_kun/model/lottery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../firestore/lottery.dart';

class CreateLottery extends StatefulWidget {
  const CreateLottery({Key? key});

  @override
  State<CreateLottery> createState() => _CreateLottery();
}

class _CreateLottery extends State<CreateLottery> {
  final titleController = TextEditingController();
  final winnerController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    String uid = ModalRoute.of(context)?.settings.arguments as String;
    int join_num = 0;

    @override
    void dispose() {
      titleController.dispose();
      winnerController.dispose();
      super.dispose();
    }

    _changeTitle() async {
      await LotteryFireStore.editTitle(uid, titleController.text);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('変更完了しました'),
        duration: const Duration(seconds: 5),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(uid),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () async {
            // フォーカスが当たっているときフォーカスを外す
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              print(currentScope.focusedChild);
              currentScope.unfocus();
              await _changeTitle();
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // タイトル
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'タイトルを入力してください',
                    ),
                    onFieldSubmitted: (String value) async {
                      _changeTitle();
                    },
                  ),
                ),
                // 当選人数
                Container(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: TextFormField(
                        controller: winnerController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(labelText: '当選人数'),
                      ),
                    ),
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
        ),
      ),
    );
  }
}
