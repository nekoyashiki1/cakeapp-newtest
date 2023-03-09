import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart' hide StreamProvider;
import 'package:cakeapp/disappearingfirstpage.dart';
import 'package:cakeapp/provider/bottom_navigation_bar_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide ChangeNotifierProvider;
//画像取得用のパッケージ
import 'package:image_picker/image_picker.dart';
import 'dart:io';
/*
Firebase configuration file lib/firebase_options.dart generated successfully with the following Firebase apps:

Platform  Firebase App Id
android   1:186128906065:android:ed3f3b5a9df773b14f8570
ios       1:186128906065:ios:d02f9655bffa48b44f8570
*/


/// firestorestorageのセキュリティ
// rules_version = '2';
// service firebase.storage {
//   match /b/{bucket}/o {
//     match /{allPaths=**} {
//       allow read, write: if false;
//     }
//   }
// }




void main() async {
  // main()の中で非同期処理を行う際には、下記を実行しなければいけないらしい
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  // iOS,androidともに縦向き固定
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_)  {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => BottomNavigationBarProvider()),
        ],
        child: MyApp(),

      ),
    );
  });
}


class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: disappearingfirstpage(),  //todo disappearingfirstpage()に戻しておく
    );
  }
}


class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  //final String title;

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
    File? _image;
  //final picker = ImagePicker();

  Future _getImage() async {
    try {
      //final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      final _image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (_image == null) return;

      final imageTemp =File(_image.path);

      setState(() {
        this._image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('テスト用'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        child: Icon(Icons.image),
      ),
    );
  }
}