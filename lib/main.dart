import 'package:flutter/material.dart';
import 'page/create_lottery.dart';
import 'page/join_lottery.dart';
import 'page/home.dart';
import 'firestore/lottery.dart';
import 'model/lottery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'util/string_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(title: '抽選くん'),
        '/create': (context) => CreateLottery(),
        '/join': (context) => JoinLottery(),
      },
    );
  }
}