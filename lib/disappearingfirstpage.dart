import 'package:flutter/material.dart';
import 'package:cakeapp/firstpage.dart';
import 'dart:async';

class disappearingfirstpage extends StatefulWidget {
  const disappearingfirstpage({Key? key}) : super(key: key);

  @override
  _disappearingfirstpageState createState() => _disappearingfirstpageState();
}

class _disappearingfirstpageState extends State<disappearingfirstpage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    //
    timer = Timer(
      //
      const Duration(seconds: 2),
      // 画面遷移の処理
          () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Makefirstpage(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.orange[50],
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('cake.',
                style: TextStyle
                  (fontSize: 50,)
            ),
          ],
        ),
      ),
    );
  }
}

