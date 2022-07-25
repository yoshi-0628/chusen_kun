import 'dart:math';

import 'package:chusen_kun/model/join.dart';
import 'package:chusen_kun/model/lottery.dart';
import 'package:chusen_kun/theme/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class TokenFireStore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference tokens =
      _firestoreInstance.collection('token');

  // 履歴を取得する
  static Future<dynamic> getHistory() async {
    try {
      final messaging = FirebaseMessaging.instance;
      final String? _token = await messaging.getToken();

      // print(_token);
      DocumentReference doc = tokens.doc(_token);
      DocumentSnapshot snap = await doc.get();
      return snap.get('uids');

    } on FirebaseException catch (e) {
      throw Error();
    }
  }
}
