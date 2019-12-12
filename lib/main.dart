import 'package:flutter/material.dart';
import 'package:people_in_space/screens/AstronautScreen.dart';
import 'package:people_in_space/screens/SplashScreen.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 4,
        navigateAfterSeconds: new AstronautScreen(),
        title: new Text(
          'How Many People in Space',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
              fontSize: 20.0),
        ),
        image: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image:
              'https://www.howmanypeopleareinspacerightnow.com/images/earth.jpg',
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 250.0,
        loaderColor: Colors.blueAccent);
  }
}
