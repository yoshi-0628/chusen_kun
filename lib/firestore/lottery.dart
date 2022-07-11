import 'package:chusen_kun/model/lottery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LotteryFireStore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference lotteries =
      _firestoreInstance.collection('lottery');

  static Future<dynamic> addLottery(Lottery newLottery) async {
    try {
      print('作成スタート');
      Firebase.initializeApp();
      DocumentReference result = await lotteries.add({
        'createdTime': newLottery.createdTime
      });
      print('成功 : $result');
      return result;
    } on FirebaseException catch (e) {
      throw new Error();
    }
  }

  // 抽選を取得する
  static Future<dynamic> getLottery(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await lotteries.doc(uid).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String,
          dynamic>;
      Lottery myLottery = Lottery(
        createdTime: data['createdTime'],
      );
      print('取得id : $myLottery');
      return true;
    } on FirebaseException catch (e) {
      print('取得エラー：$e');
      return false;
    }
  }

  // 抽選を取得する
  static Future<dynamic> editTitle(String uid,String title) async {
    try {
      print('更新スタート');
      Firebase.initializeApp();
      var result = await lotteries.doc(uid).update({
        'title': title
      });
      return result;
    } on FirebaseException catch (e) {
      print('更新エラー：$e');
      return false;
    }
  }
}
