import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'loginPage.dart';
import 'picturesPage.dart';
import 'dart:convert';


class InfoPage extends StatefulWidget {
  InfoPage({Key key, this.title, this.username, this.password}) : super(key: key);

  final String title;
  final String username;
  final String password;

  @override
  _InfoPageState createState() => _InfoPageState();
}

_makeGetRequest(username, password) async {
  var url = 'https://depression2.aliviading.repl.co/results/$username/$password';
  var response = await http.get(url);
  print(response.body);
  return json.decode(response.body);
}

picturesList(info) {

  List<String> pictures = [];

  for (int i=0; i < info["Pics Links"].length; i++) {
    pictures.add(info["Pics Links"][i]);
  }

  return pictures;
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  }
  else {
    throw 'Could not launch $url';
  }
}

class _InfoPageState extends State<InfoPage> {

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
      backgroundColor: Color.fromRGBO(224, 223, 220, 1),
      body: Container(
        width: MediaQuery.of(context).size.width,
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
                padding: EdgeInsets.fromLTRB(0, 70, 0, 50),
                child: Text("Depression Detection",
                  style: TextStyle(fontSize: 35, fontFamily: 'ChakraPetch', fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ),
              FutureBuilder(
                future: _makeGetRequest(widget.username, widget.password),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Text('Captions Result: ',
                            style: TextStyle(fontSize: 20, fontFamily: 'ChakraPetch', fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text('${snapshot.data["Captions Sentiment"]}',
                            style: TextStyle(fontSize: 20, fontFamily: 'ChakraPetch'),
                            textAlign: TextAlign.center,
                          ),
                          Text('\n Images Result: ',
                            style: TextStyle(fontSize: 20, fontFamily: 'ChakraPetch', fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text('${snapshot.data["Image Sentiment"]}',
                            style: TextStyle(fontSize: 20, fontFamily: 'ChakraPetch'),
                            textAlign: TextAlign.center,
                          ),
                          Text('\nCaptions',
                            style: TextStyle(fontSize: 20, fontFamily: 'ChakraPetch', fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.double,),
                            textAlign: TextAlign.center,
                          ),
                          Container (
                            height: MediaQuery.of(context).size.height *.35,
                            child: ListView.builder(
                              itemCount: snapshot.data["Captions"].length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var currentItem = snapshot.data["Captions"][index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text('${index+1}: $currentItem',
                                        style: TextStyle(fontSize: 20, fontFamily: 'ChakraPetch'),
                                        textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                                  child: OutlineButton(
                                    child: Text(
                                      "Pictures",
                                      style: TextStyle(fontFamily: 'ChakraPetch'),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    onPressed: (){
                                      List pictures = picturesList(snapshot.data);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PicturesPage(pictures: pictures)),
                                      );
                                    },
                                  ),
                                ),
                                OutlineButton(
                                  child: Text(
                                    "Suicide Hotline",
                                    style: TextStyle(fontFamily: 'ChakraPetch'),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  onPressed: (){
                                    const url = 'https://suicidepreventionlifeline.org/';
                                    launchURL(url);
                                  },
                                ),
                              ]
                            ),
                          )
                        ]
                      )
                    );
                  }
                  else if(snapshot.hasError) {
                    return Text('Error: ${snapshot.error.toString()}');
                  }
                  else {
                    return CircularProgressIndicator();
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}