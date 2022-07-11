import 'package:cloud_firestore/cloud_firestore.dart';

class Lottery {
  String title;
  Timestamp? createdTime;

  Lottery({this.title = '', this.createdTime});
}
