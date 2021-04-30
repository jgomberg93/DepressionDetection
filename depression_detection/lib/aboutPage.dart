import 'package:flutter/material.dart';
import 'loginPage.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  var sensitivity = 1;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (details) {
          // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          if (details.delta.dx > sensitivity) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
          else if(details.delta.dx < -sensitivity){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 70, 0, 70),
                  child: Text("Depression Detection",
                    style: TextStyle(fontSize: 50, fontFamily: 'ChakraPetch'),
                    textAlign: TextAlign.center,
                  )
              ),
              Text("Enter your Instagram username and password and this app will check your post captions and pictures and return an opinion on how depressive in nature your posts are.",
                style: TextStyle(fontSize: 25, fontFamily: 'ChakraPetch'),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
                child: Text("Swipe to go back",
                  style: TextStyle(fontSize: 20, fontFamily: 'ChakraPetch'),
                  textAlign: TextAlign.center,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}