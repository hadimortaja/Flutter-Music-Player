import 'package:flutter/material.dart';
import 'package:music_player/home.dart';
import 'package:music_player/tracks.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //  @override
  // void dispose() {
  //  super.dispose();
  //   MusicPlayerState.player?.dispose();
  // } 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Home(),
    );
  }
}


  
