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
  static final messaging = FirebaseMessaging.instance;

  // token取得
  static Future<dynamic> getHistory() async {
    try {
      final String? _token = await messaging.getToken();

      DocumentReference doc = tokens.doc(_token);
      DocumentSnapshot snap = await doc.get();
      return snap.get('uids');
    } on FirebaseException catch (e) {
      throw Error();
    }
  }

  // token更新
  static Future<dynamic> editHistory(String uid) async {
    try {
      final String? _token = await messaging.getToken();

      DocumentReference doc = tokens.doc(_token);
      QuerySnapshot ref = await tokens.where('token', isEqualTo: _token).get();

      if (ref.size > 0) {
        List<dynamic> uids = ref.docs.first.get('uids');
        uids.add(uid);
        tokens.doc(ref.docs.first.id).update({'uids': uids});
      } else {
        tokens.add({
          'token': _token,
          'uids': [uid]
        });
      }
    } on FirebaseException catch (e) {
      throw Error();
    }
  }
}
