import 'package:cakeapp/thirdpage.dart';
import 'package:flutter/material.dart';

class secondpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
         title: const Text('プロフィール入力aaaaaaaaa',
        style: TextStyle(
          color:   Colors.black,
        ),),
        backgroundColor: Colors.white,
     ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text('入力してください',
                style: TextStyle
                  (fontSize: 50,)
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)
              => thirdpage()),
                );
              },
              child: const Text('入力完了'),
            ),
          ],
        ),

      ),
    );
  }
}