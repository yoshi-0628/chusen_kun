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
      DocumentReference result = await lotteries.add({
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

  static Future<dynamic> getLottery() async {
    try {
      DocumentSnapshot documentSnapshot = await lotteries.doc('h0tFeaew8fE011fiBVqm').get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String,
          dynamic>;
      Lottery myLottery = Lottery(
        id: data['id'],
        createdTime: data['createdTime'],
      );
      print('取得id : $myLottery');
      print(myLottery.id);
      return true;
    } on FirebaseException catch (e) {
      print('取得エラー：$e');
      return false;
    }
  }
}
