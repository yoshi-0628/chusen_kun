import 'package:chusen_kun/model/join.dart';
import 'package:chusen_kun/model/lottery.dart';
import 'package:chusen_kun/theme/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LotteryFireStore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference lotteries =
      _firestoreInstance.collection('lottery');

  static Future<dynamic> addLottery(Lottery newLottery) async {
    try {
      print('作成スタート');
      await Firebase.initializeApp();
      DocumentReference result =
          await lotteries.add({'createdTime': newLottery.createdTime});
      print('成功 : $result');
      return result;
    } on FirebaseException catch (e) {
      throw Error();
    }
  }

  // 抽選を取得する
  static Future<dynamic> getLottery(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await lotteries.doc(uid).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      Lottery myLottery = Lottery(
        createdTime: data['createdTime'],
      );
      return true;
    } on FirebaseException catch (e) {
      print('取得エラー：$e');
      return false;
    }
  }

  // タイトルと当選人数を変更する
  static Future<dynamic> editLottery(String uid, Lottery editLottery) async {
    try {
      print('更新スタート');
      Firebase.initializeApp();
      var result = await lotteries.doc(uid).update({
        // タイトル
        'title': editLottery.title,
        // 当選人数
        'winners_num': editLottery.winnersNum,
      });
      return result;
    } on FirebaseException catch (e) {
      print('更新エラー：$e');
      return false;
    }
  }

  // 抽選に参加する
  static Future<dynamic> joinLottery(String uid, BuildContext context) async {
    try {
      Firebase.initializeApp();

      final messaging = FirebaseMessaging.instance;
      final String? _token = await messaging.getToken();

      // 既に登録されている場合、ダイアログを出す
      QuerySnapshot join = await lotteries
          .doc(uid)
          .collection('join')
          .where('token', isEqualTo: _token)
          .get();
      print('数');
      print(join.size);
      if (join.size == 0) {
        Join newJoin = Join(token: _token!, createdTime: Timestamp.now());
        await lotteries.doc(uid).collection('join').add({
          'token': newJoin.token,
          'createdTime': newJoin.createdTime,
        });
      } else {
        return dialog(context, '既に参加しています。', '重複して参加はできません。');
      }
    } on FirebaseException catch (e) {
      throw Error();
    }
  }

  // 参加者の人数を取得する
  static Future<int> getJoinNum(
    String uid,
  ) async {
    try {
      CollectionReference<Map<String, dynamic>> joinNum = await _getJoin(uid);
      QuerySnapshot join = await joinNum.get();
      return join.docs.length;
    } on FirebaseException catch (e) {
      throw Error();
    }
  }

  // joinの中を取得
  static Future<CollectionReference<Map<String, dynamic>>> _getJoin(
    String uid,
  ) async {
    try {
      return await lotteries.doc(uid).collection('join');
    } on FirebaseException catch (e) {
      throw Error();
    }
  }
}
