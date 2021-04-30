import 'package:flutter/material.dart';

import 'infoPage.dart';

class PicturesPage extends StatefulWidget {
  PicturesPage({Key key, this.title, this.pictures}) : super(key: key);

  final String title;
  final List pictures;

  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {

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
              MaterialPageRoute(builder: (context) => InfoPage()),
            );
          }
          else if(details.delta.dx < -sensitivity){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoPage()),
            );
          }
        },
          child: Column (
            children: <Widget> [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                  child: Text("Posted Pictures",
                    style: TextStyle(fontSize: 35, fontFamily: 'ChakraPetch', fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
              ),
              Container (
                height: MediaQuery.of(context).size.height *.8,
                child: ListView.builder(
                  itemCount: widget.pictures.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var currentItem = widget.pictures[index];
                    print('$currentItem');
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Image.network('$currentItem',
                            ),
                          )
                        ],
                      ),
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