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
import '../theme/custom_alert_dialog.dart';

class CreateLottery extends StatefulWidget {
  const CreateLottery({Key? key});

  @override
  State<CreateLottery> createState() => _CreateLottery();
}

class _CreateLottery extends State<CreateLottery> {
  final titleController = TextEditingController();
  final winnerController = TextEditingController();
  int _joinNum = 0;

  @override
  Widget build(BuildContext context) {
    String uid = ModalRoute.of(context)?.settings.arguments as String;
    @override
    void dispose() {
      titleController.dispose();
      winnerController.dispose();
      super.dispose();
    }

    _editLottery() async {
      if (!IntUtil.isNumeric(winnerController.text) &&
          winnerController.text != '') {
        return dialog(context, Message.ERR_OCCURRRNCE, Message.NOT_NUM_WINNER);
      }
      Lottery editLottery = Lottery(
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
                    onPressed: () async {
                      _joinNum = await LotteryFireStore.getJoinNum(uid);
                      setState(() {});
                    },
                    icon: const Icon(Icons.refresh)),
                QrImage(
                  data: uid,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (titleController.text.isEmpty ||
                          winnerController.text.isEmpty) {
                        dialog(context, '未設定エラー', '抽選タイトルまたは当選人数を設定してください');
                        print('未設定');
                      } else {
                        // todo: 当選人数の方が参加人数より多い場合、注意ダイアログ
                        int joinNum = await LotteryFireStore.getJoinNum(uid);
                        print(int.parse(winnerController.text));
                        int inputWinner = int.parse(winnerController.text);
                        if (joinNum > inputWinner) {
                          var dialog = CustomAlertDialog(
                            title: '注意',
                            message: '当選人数より参加人数の方が多いですがよろしいですか？（全員当選します）',
                            onNegativePressed: () {
                              Navigator.of(context).pop();
                              print('いいえ');
                            },
                            onPostivePressed: () {
                              // todo: 抽選開始
                              print('はい');
                            },
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return dialog;
                              });
                        } else {
                          // todo: 抽選開始
                        }
                      }

                      print(uid);
                    },
                    child: const Text(ButtonName.LOTTERY_START)),
                Text('参加人数 $_joinNum'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
