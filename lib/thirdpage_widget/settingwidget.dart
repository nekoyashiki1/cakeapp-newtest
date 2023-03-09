import 'package:flutter/material.dart';

class SettingWidget extends StatefulWidget {
  //EScreen({Key? key, required this.title}) : super(key: key);
  SettingWidget({Key? key}) : super(key: key);
  //final String title;
  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                child: const Text('index4のページです'),
              )
          ),
        )
    );
  }
}