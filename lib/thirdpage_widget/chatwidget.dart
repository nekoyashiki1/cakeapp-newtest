import 'package:flutter/material.dart';

class ChatWidget extends StatefulWidget {
  //GScreen({Key? key, required this.title}) : super(key: key);
  ChatWidget({Key? key}) : super(key: key);
  //final String title;
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                child: const Text('index3のページです'),
              )
          ),
        )
    );
  }
}