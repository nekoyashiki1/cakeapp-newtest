import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cakeapp/provider/bottom_navigation_bar_provider.dart';
import 'package:cakeapp/screen/h_screen.dart';
import 'package:cakeapp/screen/o_screen.dart';
import 'package:cakeapp/screen/g_screen.dart';
import 'package:cakeapp/screen/e_screen.dart';

class thirdpage extends StatefulWidget {
  static const String routeName = '/app';

  @override
  _thirdpageState createState() => _thirdpageState();
}


class _thirdpageState extends State<thirdpage> {
  var currentTab = [
    HScreen(title: '１番目'),
    OScreen(title: '2番目'),
    GScreen(title: '3番目'),
    EScreen(title: '4番目'),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBar =
    Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('メイン画面',
          style: TextStyle(
            color:   Colors.black,
          ),),
        backgroundColor: Colors.white,
      ),
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














      /*body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text('third',
                style: TextStyle
                  (fontSize: 50,)
            ),
            ElevatedButton(
              onPressed: () {print("OK");},
              child: const Text('入力完了'),
            ),
            //BottomNavigationBarTheme(data: data, child: child)
          ],
        ),

      ),
    );
  }
}*/