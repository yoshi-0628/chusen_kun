import 'package:chusen_kun/page/history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../firestore/lottery.dart';
import '../model/lottery.dart';
import '../theme/dialog.dart';
import '../const/message.dart';
import '../const/button_name.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {

  int _currentIndex = 0;
  final _pageWidgets = [
    const HomeWidget(),
    const History(),
  ];

  @override
  void initState() {
    super.initState();
    Future(() async {
      await LotteryFireStore.initFireBase();
    });
  }
  void _onItemTapped(int index) => setState(() => _currentIndex = index );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _pageWidgets.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home_outlined),
            label: 'ホーム',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            activeIcon: Icon(Icons.notes_outlined),
            label: '履歴',
            backgroundColor: Colors.green,
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
      ),
    );
  }
}


class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {
  bool _isJoinDisabled = false;
  bool _isCreateDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: Image.asset('assets/party_bingo_taikai_man.png'),
            width: 300,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.grey),
            onPressed: _isCreateDisabled
                ? null
                : () async {
              setState(() => _isCreateDisabled = true); //ボタンを無効
              Lottery newLottery = Lottery(
                createdTime: Timestamp.now(),
              );
              try {
                DocumentReference result =
                await LotteryFireStore.addLottery(newLottery);
                Navigator.pushNamed(context, '/create',
                    arguments: result.id);
              } catch (e) {
                dialog(context, Message.ERR_OCCURRRNCE,
                    Message.CREATE_LOTTERY_FAILED);
              }
              setState(() => _isCreateDisabled = false); //ボタンを有効
            },
            child: const Text(ButtonName.LOTTERY_CREATE),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
            ),
            onPressed: _isJoinDisabled
                ? null
                : () async {
              setState(() => _isJoinDisabled = true); //ボタンを無効
              Navigator.pushNamed(
                context,
                '/join',
              );
              setState(() => _isJoinDisabled = false); //ボタンを有効
            },
            child: const Text(ButtonName.LOTTERY_JOIN),
          ),
        ],
      ),
    );
  }
}
