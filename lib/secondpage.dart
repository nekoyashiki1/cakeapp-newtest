import 'package:flutter/material.dart';
import 'package:cakeapp/firstpage.dart';
import 'package:cakeapp/thirdpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
//画像取得用のパッケージ
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

//プロフィール入力画面
class secondpage extends StatefulWidget {
  secondpage();

  @override
  _secondpageState createState() => _secondpageState();
}

// プロフィール入力画面
class _secondpageState extends State<secondpage> {

  String messageText = '';
  String messageText2 = '';
  String _prefecture = '';
  //都道府県用変数
  var selectedPrefecture;
  final userID = FirebaseAuth.instance.currentUser?.uid ?? '';
  File? imageFile;
  // firestoreに画像のpathを保存するための変数
  CollectionReference _reference = FirebaseFirestore.instance.collection('imagepath');
  String imageUrl = '';


  //画像アップロード用の関数　//todo　imagepicker自作した方が良い？
  void upload(uid) async {
    try {
      // 画像を選択
      final  image = await ImagePicker().pickImage(source: ImageSource.gallery);
      //String uid;
      if (image == null) return;
      File file = File(image.path);
      setState(() {
        this.imageFile = file;
      });


      // Firebase Cloud Storageにアップロード
      //String uploadName = 'image.png';
      final Reference storageRef = await FirebaseStorage.instance.ref();
       Reference storageImage = storageRef.child('Images');

       String uniquetime =
      DateTime.now().millisecondsSinceEpoch.toString();

      Reference storageUid = storageImage.child('UID: '+uid);
      Reference storageUnique = storageUid.child(uniquetime);
      print(uid);

      await storageUnique.putFile(file); //画像をstorageにアップロード



      // todo 2/27 Reference等について考えとく
      imageUrl = await storageUnique.getDownloadURL();//画像のstorageのURLを取得

      //firestoreに画像URLを保存するためのMap変数を定義
      Map<String, String> dataToSend = {
        'imgpath': imageUrl,
      };

      //Add a new item 　　//firestoreに画像URLを保存
      _reference.add(dataToSend);
    }  catch (e) {
      print(e);
    }

  }

  /* 画像をダウンロードして表示する関数
  Future<void> download() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference imageRef = storage.ref().child("UL").child("upload-pic.png");
    String imageUrl = await imageRef.getDownloadURL();

    //画面に反映
    setState(() {
      this._img = Image.network(imageUrl);
    });

    Directory appDocDir = await getApplicationDocumentsDirectory();  //todo getApp..関数の内容　読んでおく
    File downloadToFile = File("${appDocDir.path}/download-logo.png");
    try {
      await imageRef.writeToFile(downloadToFile);
    } catch (e) {
      print(e);
    }
  }*/



  @override
  Widget build(BuildContext context) {
    // ユーザー情報を受け取る
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;
    //fire-storage用のuidの取得
    final userID = user.uid;
    final uuid = user?.uid;
    //都道府県用リスト
    final lists = Makingprefecturelist().prefecturelist;



    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
         title: const Text('プロフィール入力',
        style: TextStyle(
          color:   Colors.black,
        ),),
        backgroundColor: Colors.white,
     ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            //都道府県選択
            DropdownButton<String>(
              hint: Text('未選択'),
              value: selectedPrefecture,
              items: lists
                  .map((String list) =>
                  DropdownMenuItem(value: list, child: Text(list)))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedPrefecture = value!;
                });
              },
            ),
            // 投稿メッセージ入力
            TextFormField(
              decoration: InputDecoration(labelText: '名前'),
              // 複数行のテキスト入力
              keyboardType: TextInputType.multiline,
              // 最大3行
              maxLines: 3,
              onChanged: (String value) {
                setState(() {
                  messageText = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '自己紹介'),
              // 複数行のテキスト入力
              keyboardType: TextInputType.multiline,
              // 最大3行
              maxLines: 3,
              onChanged: (String value) {
                setState(() {
                  messageText2 = value;
                });
              },
            ),
            SizedBox(height: 20),
            ///写真選択
            ElevatedButton(
              onPressed: () {
                upload(user.uid);

              },
              child: Text('写真を追加する'),
            ),
            imageFile == null ? SizedBox.shrink() : CircleAvatar(
              radius: 95,
              backgroundImage: Image.file(imageFile!, fit: BoxFit.cover).image,
            ),
            /*Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: Image.file(imageFile).image,
                  )
                ),
                //child: Image.file(image!)),
            ),*/

            SizedBox(height: 30),
            ElevatedButton(
              child: Text('プロフィール入力完了'),
              onPressed: () async {
                final date =
                DateTime.now().toLocal().toIso8601String(); // 現在の日時
                final email = user.email; // AddPostPage のデータを参照
                // 投稿メッセージ用ドキュメント作成
                await FirebaseFirestore.instance
                    .collection('profiles') // コレクションID指定
                    .doc(uuid) // ドキュメントID自動生成
                    .set({
                  'uid': uuid,
                  'prefecture': selectedPrefecture,
                  'introduction': messageText2,
                  'name': messageText,
                  'email': email,
                  'date': date

                  //テスト用

                });
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => thirdpage()),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}


class Makingprefecturelist extends StatelessWidget {
  final prefecturelist =<String>[
    '北海道',
    '青森県',
    '岩手県',
    '宮城県',
    '秋田県',
    '山形県',
    '福島県',
    '茨城県',
    '栃木県',
    '群馬県',
    '埼玉県',
    '千葉県',
    '東京都',
    '神奈川県',
    '新潟県',
    '富山県',
    '石川県',
    '福井県',
    '山梨県',
    '長野県',
    '岐阜県',
    '静岡県',
    '愛知県',
    '三重県',
    '滋賀県',
    '京都府',
    '大阪府',
    '兵庫県',
    '奈良県',
    '和歌山県',
    '鳥取県',
    '島根県',
    '岡山県',
    '広島県',
    '山口県',
    '徳島県',
    '香川県',
    '愛媛県',
    '高知県',
    '福岡県',
    '佐賀県',
    '長崎県',
    '熊本県',
    '大分県',
    '宮崎県',
    '鹿児島県',
    '沖縄県',
  ];


  @override
  Widget build(BuildContext context) {
    return Text('');
  }
}