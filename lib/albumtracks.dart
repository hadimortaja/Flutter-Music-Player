import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/albums.dart';

import 'music_palyer.dart';

class AlbumTracks extends StatefulWidget {
  AlbumInfo albumInfo;
  AlbumTracks(this.albumInfo,);
  
  @override
  _AlbumTracksState createState() => _AlbumTracksState();
}

class _AlbumTracksState extends State<AlbumTracks> {
    final GlobalKey<MusicPlayerState> key = GlobalKey<MusicPlayerState>();

  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    getTracks();
  }

  FlutterAudioQuery audioQuery = FlutterAudioQuery();

  List<SongInfo> songs = [];
  void getTracks() async {
    songs = await audioQuery.getSongsFromAlbum(albumId: widget.albumInfo.id);
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
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
        itemBuilder: (context, index) => ListTile(
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
  }
}
