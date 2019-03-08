import 'package:flutter/material.dart';
import 'package:open_weather_app/ui/style.dart';
import 'package:http/http.dart' as http;
import "package:open_weather_app/util/utils.dart" as utils;
import 'dart:convert';
import 'dart:async';

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  void showStuff() async {
    Map data = await getWeather(utils.apiKey, "London");
    updateTempWidget("London");
    print(data.toString());
  }

  Future<Map> getWeather(String appId, String city) async {
    String api = "https://samples.openweathermap.org/data/2.5/weather?q=$city"
        "&appid=$appId";
    http.Response response = await http.get(api);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Klimatic"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.menu), onPressed: showStuff)
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset('images/umbrella.png',
                width: 490.0, fit: BoxFit.fill),
          ),
          Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0),
              child: Text(
                "Spokane",
                style: cityStyle(),
              )),
          Container(
            alignment: Alignment.center,
            child: Image.asset("images/light_rain.png"),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(30.0, 290.0, 0.0, 0.0),
              child: updateTempWidget("London"))
        ],
      ),
    );
  }

  Widget updateTempWidget(String city) {
    return FutureBuilder(
        future: getWeather(utils.apiKey, "San+Fransisco"),
        builder: (BuildContext context, AsyncSnapshot<Map> snapShot){
          if(snapShot.hasData) {
            Map content = snapShot.data;
            return Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(content['main']['temp'].toString(),
                    style: tempStyle(),),

                  )
                ],
              ),

            );
          } else {
            return Container();
          }
        }
    );
  }
}
