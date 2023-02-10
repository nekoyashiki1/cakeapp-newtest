import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  //OScreen({Key? key, required this.title}) : super(key: key);
  CalendarWidget({Key? key}) : super(key: key);
  //final String title;
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                child: const Text('index2のページです'),
              )
          ),
        )
    );
  }
}