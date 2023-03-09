import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';


class searchpage extends StatefulWidget {
  //HScreen({Key? key, required this.title}) : super(key: key);
  searchpage({Key? key}) : super(key: key);
  //final String title;
  @override
  _searchpageState createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
                color: Colors.black
            ),
            title: const Text('検索条件',
              style: TextStyle(
                color:   Colors.black,
              ),),
            backgroundColor: Colors.white,
          ),
        body: Text('aa')

      ),
    );
  }
}