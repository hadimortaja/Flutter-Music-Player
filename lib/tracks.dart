import 'dart:io';
import 'package:appbar_elevation/appbar_elevation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/music_palyer.dart';

class Tracks extends StatefulWidget {
  @override
  _TracksState createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
  MusicPlayer musicPlayer;
  int currentIndex = 0;
  final GlobalKey<MusicPlayerState> key = GlobalKey<MusicPlayerState>();
  @override
  void initState() {
    super.initState();
    getTracks();
  }

  void getTracks() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (currentIndex != songs.length - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }
    key.currentState.setSong(songs[currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollActivatedAppBarElevation(
      builder: (BuildContext context, double appBarElevation) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.pink[300],
            elevation: appBarElevation,
            centerTitle: true,
            leading: Icon(
              Icons.music_note,
              color: Colors.black,
            ),
            title: Text(
              "Musica",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: songs.length,
            itemBuilder: (context, index) =>
                // Row(
                //   children: [
                //     Container(
                //       height: 20,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),

                //     ),
                //     child: Image.asset(
                //       songs[index].albumArtwork==null?AssetImage("assets/icon.png"): FileImage(File(songs[index].albumArtwork)
                //     ),
                //     )
                //     )
                //   ],
                // )
                ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: songs[index].albumArtwork == null
                    ? AssetImage("assets/icon.png")
                    : FileImage(File(songs[index].albumArtwork)),
              ),
              title: Text(songs[index].title),
              subtitle: Text(songs[index].artist),
              onTap: () {
                currentIndex = index;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => MusicPlayer(
                          changeTrack: changeTrack,
                          songInfo: songs[currentIndex],
                          key: key,
                        )));
              },
            ),
          ),
        );
      },
    );
  }
}
