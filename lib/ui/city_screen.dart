import 'package:flutter/material.dart';

class ChangeCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _cityFieldController = new TextEditingController();
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: new Text("Change City"),
        centerTitle: true,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
              child: new Image.asset('images/white_snow.png',
                  width: 490.0, height: 1200.0, fit: BoxFit.fill)),
          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: 'Enter City',
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              new ListTile(
                  title: new FlatButton(
                      onPressed: () {
                        Navigator.pop(
                            context, {'enter': _cityFieldController.text});
                      },
                      textColor: Colors.white70,
                      color: Colors.red,
                      child: new Text('Get Weather')))
            ],
          )
        ],
      ),
    );
  }
}
