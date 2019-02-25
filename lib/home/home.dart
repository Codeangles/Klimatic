import 'package:flutter/material.dart';
import '../util/utils.dart' as util;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home2.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }


}

class HomeState extends State<Home>{
  Future _gotoHome2(BuildContext context) async {
    var router = new MaterialPageRoute<Map>(
        builder: (BuildContext context)=> new Home2());
    Map result = await Navigator.of(context).push(router);

    if(result != null && result.containsKey("info")){
      //print(result['info'].toString());
      util.defaultCity = result['info'].toString();
    }
    else
    {
      print("Nothing");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          new IconButton(

              icon: new Icon(
                  Icons.menu,
                  color: Colors.white,
              ),
              onPressed:  (){
                _gotoHome2(context);
              },
          )
        ],
        title: new Text(
          "Kilmatic",
          style: new TextStyle(

            color: Colors.white,
          ),
        ),

        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),

      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
                'images/umbrella.png',
                width: 490.0,
                height: 1200.0,
                fit: BoxFit.fill,
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(15.0),
            child: new Text(
              util.defaultCity,
            style: new TextStyle(
              color: Colors.white,
              fontSize: 21.0,
            ),
            ),
          ),
          new Container(
            alignment: Alignment.center,
            child: Image.asset('images/light_rain.png'),
          ),
          new Container(
            padding: EdgeInsets.fromLTRB(30.0, 290.0, 0.0, 0.0),
            child: UpdateTempWidget(util.defaultCity),
          )
        ],
      ),

    );
  }

  Future<Map> getWeather(String appId, String city) async{

    String apiURl = "https://api.openweathermap.org/data/2.5/weather?q=$city,in&appid=$appId&units=metric";
    http.Response response = await http.get(apiURl);
    return json.decode(response.body);
  }

  Widget UpdateTempWidget(String city){
    return new FutureBuilder(
      future: getWeather(util.appId, city),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
        if(snapshot.hasData){
          Map content = snapshot.data;
          return new Container(
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    content['main']['temp'].toString(),
                    style: new TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );

  }


}