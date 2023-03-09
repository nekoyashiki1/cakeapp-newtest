import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cakeapp/provider/bottom_navigation_bar_provider.dart';
import 'package:cakeapp/thirdpage_widget/matchwidget.dart';
import 'package:cakeapp/thirdpage_widget/calendarwidger.dart';
import 'package:cakeapp/thirdpage_widget/chatwidget.dart';
import 'package:cakeapp/thirdpage_widget/settingwidget.dart';

class thirdpage extends StatefulWidget {
  static const String routeName = '/app';

  @override
  _thirdpageState createState() => _thirdpageState();
}


class _thirdpageState extends State<thirdpage> {
  var currentTab = [
    MatchWidget(),
    CalendarWidget(),
    ChatWidget(),
    SettingWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBar =
    Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      body:
        currentTab[bottomNavigationBar.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: bottomNavigationBar.currentIndex,
          onTap: (index) {
            bottomNavigationBar.currentIndex = index;
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
              icon: Icon(Icons.search), label: 'マッチ'),
        BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'カレンダー'),
        BottomNavigationBarItem(
              icon: Icon(Icons.question_answer), label: 'チャット'),
        BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: '設定'),
          ],

        ),
         );
  }
}