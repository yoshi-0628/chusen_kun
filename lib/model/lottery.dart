import 'package:cloud_firestore/cloud_firestore.dart';

class Lottery {
  String title;
  String winnersNum;
  String endFlg;
  String createrUid;
  Timestamp? createdTime;

  Lottery(
      {this.title = '',
      this.winnersNum = '',
      this.endFlg = '0',
      this.createrUid = '',
      this.createdTime});
}
