import 'package:flutter/material.dart';

class OScreen extends StatefulWidget {
  OScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _OScreenState createState() => _OScreenState();
}

class _OScreenState extends State<OScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),*/
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                child: const Text('index2のページです'),
              )),
        ));
  }
}