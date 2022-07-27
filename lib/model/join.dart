import 'package:cloud_firestore/cloud_firestore.dart';

class Join {
  String token;
  String winnerFlg;
  Timestamp? createdTime;

  Join({this.token = '',this.winnerFlg = '0', this.createdTime});
}
