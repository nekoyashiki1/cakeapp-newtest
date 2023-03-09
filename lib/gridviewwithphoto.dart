/*
class MatchWidget extends StatefulWidget {
  //HScreen({Key? key, required this.title}) : super(key: key);
  MatchWidget({Key? key}) : super(key: key);
  //final String title;
  @override
  _MatchWidgetState createState() => _MatchWidgetState();
}

class _MatchWidgetState extends State<MatchWidget> {
  @override
  var gazou = Image.network('https://nukumori-icon.com/wp/wp-content/uploads/2022/10/nu01321p.jpg');

  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text('個人のお誘い'),
            onPressed: () {print('ok');},
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text('複数人のお誘い'),
            onPressed: () {print('ok');},
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)
              => profilepage(openedprofileuser: '閲覧されてるメアド')),
              );
            },
            child: Container(
                child:SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3FXl1Qyc3GTUtIagmtglvgzsICwWzdKNobg&usqp=CAU'),
                      Container(
                          margin: EdgeInsets.all(24.0),
                          child: Text(
                              'Meeage'
                          )
                      )
                    ],
                  ),
                )
            ),
          ),

          Container(
              child:SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3FXl1Qyc3GTUtIagmtglvgzsICwWzdKNobg&usqp=CAU'),
                    Container(
                        margin: EdgeInsets.all(24.0),
                        child: Text(
                            'Meeage'
                        )
                    )
                  ],
                ),
              )
          ),

        ],
      ),
    );

  }
}
*/
