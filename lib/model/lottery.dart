import 'package:cloud_firestore/cloud_firestore.dart';

class Lottery {
  String title;
  String winnersNum;
  Timestamp? createdTime;

  Lottery({this.title = '',this.winnersNum = '', this.createdTime});
}
