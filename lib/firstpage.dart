import 'package:flutter/material.dart';
import 'package:cakeapp/secondpage.dart';

class firstpage extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
   return Scaffold(
   backgroundColor: Colors.orange[50],
   body: Center(

    child: Column(
     mainAxisAlignment: MainAxisAlignment.center,

     children: [
     Text('cake.',
      style: TextStyle
      (fontSize: 50,)
       ),
       SizedBox(height: 100,),
       ElevatedButton(
       onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)
         => secondpage()),
         );
         },
        child: const Text('新規登録'),
       ),
       ],
        ),

        ),
        );
   }
}