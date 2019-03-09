import 'package:flutter/material.dart';
import 'package:open_weather_app/ui/style.dart';
import 'package:http/http.dart' as http;
import "package:open_weather_app/util/utils.dart" as utils;
import 'package:open_weather_app/ui/city_screen.dart';
import 'dart:convert';
import 'dart:async';

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => new _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  String _cityName = utils.defaultCity;

  Future _goToNextScreen(BuildContext context) async {
    Map result = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new ChangeCity();
    }));
    if (result != null && result.containsKey("enter")) {
      setState(() {
        _cityName = result['enter'];
      });
    }
  }

  void showStuff() async {
    Map data = await getWeather(utils.apiKey, utils.defaultCity);
    updateTempWidget(utils.defaultCity);
    print(data.toString());
  }

  Future<Map> getWeather(String appId, String city) async {
    String api = "http://api.openweathermap.org/data/2.5/weather?q=$city"
        "&APPID=$appId&units=metric";
    http.Response response = await http.get(api);

    if (response.statusCode < 400)
      return json.decode(response.body);
    else
      return {
        "main": {"temp": "~~~"}
      };
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Klimatic"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.menu), onPressed: () => _goToNextScreen(context))
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: Image.asset('images/umbrella.png',
                width: 490.0, fit: BoxFit.fill),
          ),
          new Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0),
              child: new Text(
                _cityName,
                style: cityStyle(),
              )),
          new Container(
            alignment: Alignment.center,
            child: Image.asset("images/light_rain.png"),
          ),
          new Container(
              margin: const EdgeInsets.fromLTRB(28.0, 290.0, 0.0, 0.0),
              child: updateTempWidget(_cityName))
        ],
      ),
    );
  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
        future:
            getWeather(utils.apiKey, city == null ? utils.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapShot) {
          if (snapShot.hasData) {
            Map content = snapShot.data;
            return new Container(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      content['main']['temp'].toString(),
                      style: tempStyle(),
                    ),
                    subtitle: new ListTile(
                      title: new Text(
                        "Humidity: ${content['main']['humidity'].toString()}\n"
                            "Min: ${content['main']['temp_min'].toString()} C\n"
                            "Max: ${content['main']['temp_max'].toString()} C",
                        style: tempSubStyle(),
                      )
                    ),                  )
                ],
              ),
            );
          } else {
            return new Container();
          }
        });
  }
}
