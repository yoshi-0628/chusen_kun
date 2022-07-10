import 'package:chusen_kun/model/lottery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class LotteryFireStore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference lotteries =
      _firestoreInstance.collection('lottery');

  static Future<dynamic> addLottery(Lottery newLottery) async {
    try {
      print('作成スタート');
      Firebase.initializeApp();
      var result = await lotteries.add({
        'id': newLottery.id,
        'createdTime': newLottery.createdTime
      });
      print('成功 : $result');
      return true;
    } on FirebaseException catch (e) {
      print('投稿エラー：$e');
      return false;
    }
  }
}
