import 'package:flutter/material.dart';

class GScreen extends StatefulWidget {
  GScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _GScreenState createState() => _GScreenState();
}

class _GScreenState extends State<GScreen> {
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
                child: const Text('index3のページです'),
              )),
        ));
  }
}