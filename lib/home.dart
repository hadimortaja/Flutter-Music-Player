import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player/tracks.dart';

import 'albums.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int _currentIndex = 0;
  final tabs = [
    Albums(),
    Tracks(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
         selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) => setState(
            () {
              _currentIndex = index;
            },
          ),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.album_sharp),
              title: Text('Albums'),
              activeColor: Colors.red,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.music_note),
              title: Text('Songs'),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            
          ]
      ),
    );
  }
}