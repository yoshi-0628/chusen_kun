import 'package:chusen_kun/page/join_success.dart';
import 'package:flutter/material.dart';
import 'page/create_lottery.dart';
import 'page/join_lottery.dart';
import 'page/home.dart';

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
        '/joinSuccess': (context) => JoinSuccess(),
      },
    );
  }
}
