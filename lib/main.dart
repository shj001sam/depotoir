import 'package:depotoir_test/acceuil.dart';
import 'package:depotoir_test/camera.dart';
import 'package:depotoir_test/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'les widgets basique', 
      theme: new ThemeData(
        primarySwatch: Colors.red
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }

}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  
 
  int currentIndex = 0;
  final List<Widget> _children = [
    Acceuil(),
    Menu(),
    Camera(),
  ];

  void onTappedBar(int index){
    setState(() {
      currentIndex = index;
    });
  }

  String nouvelleListe;

  @override
  Widget build(BuildContext context) {
  
    return new Scaffold(
      body: _children[currentIndex],

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 25,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: new Icon(Icons.map,),
            title: Text('Acceuil'),
            activeColor: Colors.blue[900],
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: new Icon(Icons.list),
            title: Text('Liste'),
            activeColor: Colors.blue[900],
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: new Icon(Icons.photo_camera),
            title: Text('Camera'),
            activeColor: Colors.blue[900],
            textAlign: TextAlign.center,
          ),
          
        ],
      ),
      
    );
  }
  

}