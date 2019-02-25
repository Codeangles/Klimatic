import 'package:flutter/material.dart';
import 'home.dart';
class Home2 extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Home2State();
  }

}

class Home2State extends State<Home2>{
  var _locationController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Second Screen"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),

        body: new Stack(
          children: <Widget>[
            new Center(
              child: new Image.asset(
                'images/white_snow.png',
                width: 490.0,
                height: 1200.0,
                fit: BoxFit.fill,
              ),
            ),

            new Container(
              padding: EdgeInsets.all(15.0),
              child: new ListTile(
                title: new TextField(
                  controller: _locationController,
                  decoration: new InputDecoration(
                    labelText: 'Enter Your Location',
                  ),
                ),
              ),

            ),

            new Container(
              padding: EdgeInsets.all(85.0),
              child: new ListTile(
                title: new RaisedButton(
                  onPressed: (){
                    Navigator.pop(context,{
                      'info': _locationController.text,
                    });

                  },

                  child: new Text(
                    "Button",
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

              ),

            )
          ],
        )
    );
  }

}

