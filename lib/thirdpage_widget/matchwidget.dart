import 'package:flutter/material.dart';
import 'package:cakeapp/firstpage.dart';
import 'package:cakeapp/secondpage.dart';
import 'package:cakeapp/matchingwidget_searchpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
//画像取得用のパッケージ
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';




class MatchWidget extends StatefulWidget {
  //HScreen({Key? key, required this.title}) : super(key: key);
  MatchWidget({Key? key}) : super(key: key);
  //final String title;
  @override
  _MatchWidgetState createState() => _MatchWidgetState();
}

class _MatchWidgetState extends State<MatchWidget> {
  var favorite;
  var favoriteuserfrom;
  var favoriteuserto;
  var values;



  @override
  var gazou = Image.network('https://nukumori-icon.com/wp/wp-content/uploads/2022/10/nu01321p.jpg');

  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;
    //UIDの取得、表示
    final auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid.toString();
    print(uid);

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text('ホーム'),
              bottom: TabBar(
              tabs: <Widget>[
                Tab(text: '個人のお誘い'),
                Tab(text: 'グループのお誘い'),
               ],
               )
    ),


       body: TabBarView(
        children: <Widget>[
          KOZINwidget(),
          GROUPwidget(),
    ],
      ),
          ),
    );

  }
}

class KOZINwidget extends StatefulWidget {
  KOZINwidget({Key? key} ) : super(key: key);
  @override
  _KOZINwidgetState createState() => _KOZINwidgetState();
}

//個人のお誘いページ
class _KOZINwidgetState extends State<KOZINwidget> {

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Text('ログイン情報：${user.email}'),
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: IconButton(icon: Icon(Icons.search, size: 40,),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => searchpage()));
              },)
        ),
        Expanded(
          // Stream
          // 非同期処理の結果を元にWidgetを作れる
          child: StreamBuilder<QuerySnapshot>(
            // ユーザー一覧を取得（非同期処理）
            // 投稿日時でソート
            stream: FirebaseFirestore.instance
                .collection('profiles')
                .orderBy('date')
                .snapshots(),
            builder: (context, snapshot) {
              // データが取得できた場合
              if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                bool favorite;
                return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  children: documents.map((document) {
                    return Card(
                      child: ListTile(
                        title: Text('名前: ' + document['name']),
                        subtitle: Text(document['email']),
// 自分の投稿メッセージの場合は削除ボタンを表示
                        trailing: Wrap(
                            direction: Axis.vertical,
//spacing: 8,
                            children: [

                              document['email'] == user.email
                                  ? IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
// 投稿メッセージのドキュメントを削除
                                  await FirebaseFirestore.instance
                                      .collection('profiles') //Todo
                                      .doc(document.id)
                                      .delete();
                                },
                              )
                                  : SizedBox.shrink(),
                            ]
                        ),
                        onTap: () {
//他人のプロフィール画面に遷移閲覧
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  profilepage(
                                      openedprofileuser: document['email']),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              }
              // データが読込中の場合
              return Center(
                child: Text('読込中'),
              );
            },
          ),
        ),
      ],
    );

  }
}

class GROUPwidget extends StatefulWidget {
  GROUPwidget({Key? key} ) : super(key: key);
  @override
  _GROUPwidgetState createState() => _GROUPwidgetState();
}

class _GROUPwidgetState extends State<GROUPwidget> {

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Text('ログイン情報：${user.email}'),
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: IconButton(icon: Icon(Icons.search, size: 40,),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => searchpage()));
              },)
        ),
        Expanded(
          // Stream
          // 非同期処理の結果を元にWidgetを作れる
          child: StreamBuilder<QuerySnapshot>(
            // ユーザー一覧を取得（非同期処理）
            // 投稿日時でソート
            stream: FirebaseFirestore.instance
                .collection('profiles')
                .orderBy('date')
                .snapshots(),
            builder: (context, snapshot) {
              // データが取得できた場合
              if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                bool favorite;
                return ListView(
                  //rossAxisCount: 2,
                  //childAspectRatio: 3 / 4,c
                  children: documents.map((document) {
                    return Card(
                      child: ListTile(
                        title: Text('名前: ' + document['name']),
                        subtitle: Text(document['email']),
// 自分の投稿メッセージの場合は削除ボタンを表示
                        trailing: Wrap(
                            direction: Axis.vertical,
//spacing: 8,
                            children: [

                              document['email'] == user.email
                                  ? IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
// 投稿メッセージのドキュメントを削除
                                  await FirebaseFirestore.instance
                                      .collection('profiles') //Todo
                                      .doc(document.id)
                                      .delete();
                                },
                              )
                                  : SizedBox.shrink(),
                            ]
                        ),
                        onTap: () {
//他人のプロフィール画面に遷移閲覧
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  profilepage(
                                      openedprofileuser: document['email']),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              }
              // データが読込中の場合
              return Center(
                child: Text('読込中'),
              );
            },
          ),
        ),
      ],
    );
  }
}



//他人のプロフィール画面
class profilepage extends StatefulWidget {
  //HScreen({Key? key, required this.title}) : super(key: key);
  profilepage({Key? key, this.openedprofileuser} ) : super(key: key);
  final openedprofileuser;
  @override
  _profilepageState createState() => _profilepageState();
}


//他人のプロフィール画面
class _profilepageState extends State<profilepage> {

   //final String openedprofileuser;
   var  favorite;
   var openedprofileuser;
   var testvalue;

  //
   Future fetchuserdata() async {
     final UserState userState = Provider.of<UserState>(context);
     final User user = userState.user!;
     final snapShota = await FirebaseFirestore.instance.collection('profiles')
                                                       .where('uid', isEqualTo: user.uid)
                                                      .get();
     //var test = snapShota.data!.docs;
     //bool favorite = snapShota['likeor'];
     print('タイプsnapshota');
     print(snapShota.runtimeType);
     //print(Future.value(favorite));
     //print(favorite);
     var ddd = snapShota.docs.map((document) {
       var data = document.data()! as Map<String, dynamic>;
        final fff = data['name'];
     });
     print(ddd.runtimeType);


     return snapShota;
   }




  LikeButton(favoriteuserfrom, favoriteuserto, uuidfrom, uuidto) async {//todo favorite変数にfirestoreの値を入れる trueorfalse
    //todo 2/25 firestoreのboolを参照した上でいいねボタンの色を管理したい
    /*FirebaseFirestore.instance
        .collection('profiles') // コレクションID
        .doc(uuidfrom) // ドキュメントID << usersコレクション内のドキュメント
        .collection('sendingfavorites') // サブコレクションID
        .doc('id_123') // ドキュメントID << サブコレクション内のドキュメント
        .set({'likefrom': favoriteuserfrom, 'liketo': favoriteuserto, 'likeor': true});*/

    var testdocument = FirebaseFirestore.instance
        .collection('profiles')
        .doc('ARrI2RhT4ETzpsCUjjI2A0YFa8r2')
        .collection('sendingfavorites')
        .doc('id_123')
        .get();

  //todo 2/25
    final snapShota = await FirebaseFirestore.instance.collection('profiles')
        .doc('ARrI2RhT4ETzpsCUjjI2A0YFa8r2')
        .collection('sendingfavorites')
        .doc('id_123')
        .get();
    bool favorite = snapShota['likeor'];



    return IconButton(

      icon: Icon(
        favorite == true ? Icons.favorite : Icons.favorite_border,
        color: favorite == true ? Colors.red : Colors.black38,
      ),

      onPressed: () async {
        //test
        final testdocument =  await FirebaseFirestore.instance
            .collection('profiles')
            .doc(uuidfrom)
            .collection('sendingfavorites')
            .doc('id_123')
            .get();

        setState(() {
          //favorite = testdocument['likeor'];

          if (favorite != true) {
            //ハートが押されたときにfavoriteにtrueを代入している
            favorite = true;
            // firestoreに誰に向けた誰かからのlikeかの情報入れる
            FirebaseFirestore.instance
                .collection('profiles') // コレクションID
                .doc(uuidfrom) // ドキュメントID << usersコレクション内のドキュメント
                .collection('sendingfavorites') // サブコレクションID
                .doc('id_123') // ドキュメントID << サブコレクション内のドキュメント
                .set({'likefrom': favoriteuserfrom, 'liketo': favoriteuserto, 'likeor': true});


          } else  {
            favorite = false;

            FirebaseFirestore.instance
                .collection('profiles') // コレクションID
                .doc(uuidfrom) // ドキュメントID << usersコレクション内のドキュメント
                .collection('sendingfavorites') // サブコレクションID
                .doc('id_123') // ドキュメントID << サブコレクション内のドキュメント
                .delete();
          }
        });
      },
      
    );
  }

  Image? _img;
  var imageUrl;
  CollectionReference _reference = FirebaseFirestore.instance.collection('imagepath');
  //画像をfire-storageからダウンロード
  Future<void> download() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference imageRef = storage.ref().child("UL").child("upload-pic.png");
    String imageUrl = await imageRef.getDownloadURL();

    //画面に反映
    setState(() {
      this._img = Image.network(imageUrl);
      this.imageUrl = imageUrl;
    });

    Directory appDocDir = await getApplicationDocumentsDirectory();  //todo getApp..関数の内容　読んでおく
    File downloadToFile = File("${appDocDir.path}/download-logo.png");
    try {
      await imageRef.writeToFile(downloadToFile);
    } catch (e) {
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    // ユーザー情報を受け取る
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;

    openedprofileuser = widget.openedprofileuser;
    //var favorite = fetchfavorite();
    var image = _img;

    return Scaffold(
        appBar: AppBar(
          title: Text('プロフィール画面'),
          ),


        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text('ログイン情報：${user.email}'),
            ),

            ElevatedButton(
              child: Text('テストよう'),
                onPressed: () async {
                  //test
                  final testdocument =  await FirebaseFirestore.instance
                      .collection('profiles')
                      .doc('ARrI2RhT4ETzpsCUjjI2A0YFa8r2')
                      .collection('sendingfavorites')
                      .doc('id_123')
                      .get();

                  print('favorite');
                  print(favorite);

                  setState(() {
                    testvalue = testdocument['likeor'];

                  });
                },
            ),
            ElevatedButton(
              child: Text('テストようbu-ru　画像DL'),
              onPressed: () async {
                //test
                final testdocument =  await FirebaseFirestore.instance
                    .collection('profiles')
                    .doc('ARrI2RhT4ETzpsCUjjI2A0YFa8r2')
                    .collection('sendingfavorites')
                    .doc('id_123')
                    .get();
                print('testvalue.runtimeType');
                print(testvalue.runtimeType);
                print(testvalue);
                ///画像ダウンロード
                download();
              },
            ),
            if (image != null) Container(
              width: 190.0,
              height: 190.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,  //画像を丸型で表示
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(imageUrl)
                  )
              ),
            ),


            //documentを取得
              // Stream
              // 非同期処理の結果を元にWidgetを作れる
               Expanded(
                 child: StreamBuilder<QuerySnapshot>(
                  //emailが一致するデータだけ取得することで一人のプロフィール画面のみを見れるように
                  stream: FirebaseFirestore.instance
                      .collection('profiles')
                      .where('email', isEqualTo: openedprofileuser)
                      .snapshots(),
                  builder: (context, snapshot) {
                    // データが取得できた場合
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents = snapshot.data!.docs;


                      //print(testvalue.value);  //todo エラーは出ないが、titleにvalue[]が反映されてない
                      //print(testvalue);
                      // 取得した投稿メッセージ一覧を元にリスト表示
                      return ListView(
                        itemExtent: 600,
                        children: documents.map((document) {
                      return ListTile(

                          title: Text('名前 '+document['name']),
                          subtitle: Text('自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']+
                              '自己紹介あああああああああああああああああああああ '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                          +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                          +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']
                              +'自己紹介 '+'\n'+document['introduction']+'\n'+'所在地:'+document['prefecture']),
                        //*subtitle: Text(document['introduction']),*/
                        //trailing: LikeButton(user.email, document['email'], user.uid, document['uid']),
                         );
                        }).toList(),
                      );
                    }
                    // データが読込中の場合
                    return Center(
                      child: Text('読込中...'),
                    );
                  },
              ),
               ),




//user.emailを使うにはfetchfavoriteじゃない方が良い？　全体のデータを取りに行く
            // DocumentSnapshotから<QuerySnapshot<Object?>>に書き換えないと
            // メソッドが使えないので変更する!
            FutureBuilder<QuerySnapshot<Object?>>(
              future: FirebaseFirestore.instance.collection('profiles')
                  .doc(user.uid)
                  .collection('sendingfavorites')
                  .get(),
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  //final List<DocumentSnapshot> documents = snapshot.data;
                  //snapshot.dataがfirestoreのlikeor
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;


                  //三項演算子でsendingfavoritesのdocumentデータがない時の処理を管理
                    var data = documents.length > 0 ? documents[0].data()! as Map<String, dynamic> : {'likeor':  false};
                    var favorite = data['likeor'];
                    print(favorite);


                  return favorite == true ? IconButton(icon: Icon(Icons.favorite, size: 40), onPressed: ()
                {
                  setState(() {
                  //favorite = testdocument['likeor'];

                    favorite = false;

                    FirebaseFirestore.instance
                        .collection('profiles') // コレクションID
                        .doc(user.uid) // ドキュメントID << usersコレクション内のドキュメント
                        .collection('sendingfavorites') // サブコレクションID
                        .doc('id_123') // ドキュメントID << サブコレクション内のドキュメント
                        .delete();

                });
                }
                  )
                    : IconButton(icon: Icon(Icons.favorite_border, size: 40), onPressed: ()
                  {
                    setState(() {
                      //favorite = testdocument['likeor'];
                        //ハートが押されたときにfavoriteにtrueを代入している
                        favorite = true;
                        // firestoreに誰に向けた誰かからのlikeかの情報入れる
                        //todo 2/26 favoriteusertoの変数をどうやって取ってくるか
                        FirebaseFirestore.instance
                            .collection('profiles') // コレクションID
                            .doc(user.uid) // ドキュメントID << usersコレクション内のドキュメント
                            .collection('sendingfavorites') // サブコレクションID
                            .doc('id_123') // ドキュメントID << サブコレクション内のドキュメント
                            .set({'likefrom': user.uid, 'liketo': openedprofileuser, 'likeor': true});



                    });
                  }
                  );
      }
                 else {
                  return Text('Loading.');
                }
                 if (snapshot.hasError) {
                   return Text('error');
                 }
              },
            ),
            SizedBox(height: 30),

          ],
        ),


    );
  }
}


/*class MatchGridview extends StatefulWidget {
  //HScreen({Key? key, required this.title}) : super(key: key);
  MatchGridview({Key? key}) : super(key: key);
  //final String title;
  @override
  _MatchGridviewState createState() => _MatchGridviewState();
}*/

/*class _MatchGridviewState extends State<MatchGridview> {


  //var user;
  //var documents;
  var favorite;


  LikeButton(favoriteuserfrom, favoriteuserto, uuidfrom, uuidto) {
    return IconButton(

      icon: Icon(
        favorite == true ? Icons.favorite : Icons.favorite_border,
        color: favorite == true ? Colors.red : Colors.black38,
      ),

      onPressed: () {
        setState(() {
          if (favorite != true) {
            //ハートが押されたときにfavoriteにtrueを代入している
            favorite = true;
            print(uuidfrom);
            // firestoreに誰に向けた誰かからのlikeかの情報入れる
            FirebaseFirestore.instance
                .collection('profiles') // コレクションID
                .doc(uuidfrom) // ドキュメントID << usersコレクション内のドキュメント
                .collection('sendingfavorites') // サブコレクションID
                .doc('id_123') // ドキュメントID << サブコレクション内のドキュメント
                .set({'likefrom': favoriteuserfrom, 'liketo': favoriteuserto});
          } else {
            favorite = false;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}*/

            /*onPressed: ()  {
        setState(()  {
          //likeが押された時
          if (favorite != true) {
            //ハートが押されたときにfavoriteにtrueを代入している
            favorite = true;

            // firestoreに誰に向けた誰かからのlikeかの情報入れる
             FirebaseFirestore.instance
                .collection('profiles') // コレクションID
                .doc(uuidfrom) // ドキュメントID << usersコレクション内のドキュメント
                .collection('sendingfavorites') // サブコレクションID
                .doc('id_123') // ドキュメントID << サブコレクション内のドキュメント
                .set({'likefrom': favoriteuserfrom, 'liketo': favoriteuserto}); // データ
          }
          //likeが押されてない時
           else {
            favorite = false;
          }
        });
      },*/





/*
 @override
 Widget build(BuildContext context) {
    var user;
    var documents;
   return GridView.count(
     crossAxisCount: 2,
     childAspectRatio: 3 / 4,
     children: documents.map((document) {
       return Card(
         child: ListTile(
           title: Text('名前: ' + document['name']),
           subtitle: Text(document['email']),
// 自分の投稿メッセージの場合は削除ボタンを表示
           trailing: Wrap(
               direction: Axis.vertical,
//spacing: 8,
               children: [

                 document['email'] == user.email
                     ? IconButton(
                   icon: Icon(Icons.delete),
                   onPressed: () async {
// 投稿メッセージのドキュメントを削除
                     await FirebaseFirestore.instance
                         .collection('profiles') //Todo
                         .doc(document.id)
                         .delete();
                   },
                 )
                     : SizedBox.shrink(),
//いいねボタン
                 LikeButton(
                     user.email, document['email'], user.uid, document['uid']),
               ]
           ),
           onTap: () {
//他人のプロフィール画面に遷移閲覧
             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) =>
                     profilepage(openedprofileuser: document['email']),
               ),
             );
           },
         ),
       );
     }).toList(),
   );
 }
}*/






