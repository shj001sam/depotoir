import 'package:depotoir_test/acceuil.dart';
import 'package:depotoir_test/camera.dart';
import 'package:depotoir_test/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:introduction_screen/introduction_screen.dart';


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
      home: OnBoardingPage(),
    );
  }

}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Home()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('images/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('image1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body:
              "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('image2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('image3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Another title page",
          body: "Another beautiful body text for this example onboarding",
          image: _buildImage('image2'),
          footer: RaisedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'FooButton',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Title of last page",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on ", style: bodyStyle),
              Icon(Icons.edit),
              Text(" to edit a post", style: bodyStyle),
            ],
          ),
          image: _buildImage('image1'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
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