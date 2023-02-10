import 'package:flutter/material.dart';
import 'package:cakeapp/disappearingfirstpage.dart';

class MatchWidget extends StatefulWidget {
  //HScreen({Key? key, required this.title}) : super(key: key);
  MatchWidget({Key? key}) : super(key: key);
  //final String title;
  @override
  _MatchWidgetState createState() => _MatchWidgetState();
}

class _MatchWidgetState extends State<MatchWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('個人のお誘い'),
              onPressed: () {print('ok');},
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('複数人のお誘い'),
              onPressed: () {print('ok');},
            ),
          ],
    ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                child: const Text('index１のページです'),
              )
          ),
        )
    );
  }
}