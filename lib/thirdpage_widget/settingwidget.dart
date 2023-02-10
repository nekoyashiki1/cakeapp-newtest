import 'package:flutter/material.dart';

class EScreen extends StatefulWidget {
  //EScreen({Key? key, required this.title}) : super(key: key);
  EScreen({Key? key}) : super(key: key);
  //final String title;
  @override
  _EScreenState createState() => _EScreenState();
}

class _EScreenState extends State<EScreen> {
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