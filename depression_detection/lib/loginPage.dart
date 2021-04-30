import 'package:depression_detection/infoPage.dart';
import 'package:flutter/material.dart';

import 'aboutPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var sensitivity = 1;
  static String username = "";
  static String password = "";

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
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        child: SingleChildScrollView(
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
              Text("Enter your Instagram Username and Password",
                style: TextStyle(fontSize: 16, fontFamily: 'ChakraPetch', color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (v)=>setState((){username=v;}),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Username',
                    labelStyle: TextStyle(fontFamily: 'ChakraPetch', color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  onChanged: (v)=>setState((){password=v;}),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(fontFamily: 'ChakraPetch', color: Colors.white),
                  ),
                ),
              ),
              OutlineButton(
                child: Text(
                    "Sign In",
                    style: TextStyle(fontFamily: 'ChakraPetch', color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                ),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InfoPage(username: username, password: password)),
                  );
                  print(username + " " + password);
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: OutlineButton(
                  child: Text(
                    "About This App",
                    style: TextStyle(fontFamily: 'ChakraPetch', color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}