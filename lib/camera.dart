import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CameraState();

}


class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Camera'),
        leading: new Icon(Icons.camera),
        elevation: 10.0,
        centerTitle: true, 
      ),
      body: new Center(
        child: new Text("Pour la camera")
      ),
    );
  }
}