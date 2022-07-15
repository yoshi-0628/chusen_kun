import 'package:chusen_kun/const/button_name.dart';
import 'package:chusen_kun/model/lottery.dart';
import 'package:chusen_kun/util/int_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../firestore/lottery.dart';
import '../theme/dialog.dart';
import '../const/message.dart';
import '../const/object_name.dart';

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

    _editLottery() async {
      if (!IntUtil.isNumeric(winnerController.text) && winnerController.text != '') {
        return dialog(context, Message.ERR_OCCURRRNCE, Message.NOT_NUM_WINNER);
      }
      Lottery editLottery = new Lottery(
        title: titleController.text,
        winnersNum: winnerController.text,
      );
      await LotteryFireStore.editLottery(uid, editLottery);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(Message.EDIT_SUCCESS),
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
              await _editLottery();
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
                      labelText: ObjectName.LOTTERY_TITLE,
                    ),
                    onFieldSubmitted: (String value) async {
                      await _editLottery();
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
                        decoration: const InputDecoration(
                            labelText: ObjectName.WINNERS_NUM),
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
                    child: const Text(ButtonName.LOTTERY_START)),
                Text('参加人数 $join_num'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
