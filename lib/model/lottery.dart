import 'package:cloud_firestore/cloud_firestore.dart';

class Lottery {
  String id;
  Timestamp? createdTime;

  Lottery({this.id = '', this.createdTime});
}