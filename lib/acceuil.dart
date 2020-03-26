import 'package:flutter/material.dart';

class Acceuil extends StatefulWidget {
  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Maps'),
        leading: new Icon(Icons.map),
        elevation: 10.0,
        centerTitle: true, 
      ),
      body: new Center(
        child: new Text("Ici sera la ou le  Maps")
      ),
    );
  }
}