import 'package:cloud_firestore/cloud_firestore.dart';

class Join {
  String token;
  Timestamp? createdTime;

  Join({this.token = '', this.createdTime});
}
