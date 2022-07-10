import 'package:chusen_kun/model/lottery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:math' as math;

class LotteryFireStore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference lotteries = _firestoreInstance.collection('lottery');

  static Future<dynamic> addLottery() async {
    try{
      Firebase.initializeApp();
      String newId = _randomString(8);
      var result = await lotteries.add({
        'id': newId,
        'createdTime' : Timestamp.now()
      });
      print('成功');

    } on FirebaseException catch(e) {
      print('投稿エラー：$e');
    }
  }

  static String _randomString(int length) {
    String randomStr = "";

    var random = math.Random();

    for (var i = 0; i < length; i++) {
      int alphaNum = 65 + random.nextInt(26);
      int isLower = random.nextBool() ? 32 : 0;

      randomStr += String.fromCharCode(alphaNum + isLower);
    }

    return randomStr;
  }
}