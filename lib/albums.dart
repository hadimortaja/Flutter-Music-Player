import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/albumtracks.dart';

class Albums extends StatefulWidget {
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<AlbumInfo> albums = [];

  @override
  void initState() {
    super.initState();
    getAlbums();
  }

  void getAlbums() async {
    albums = await audioQuery.getAlbums();
    setState(() {
      albums = albums;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
        child: GridView.builder(
            itemCount: albums.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => AlbumTracks(albums[index])));
                },
                child: Card(
                  child: new GridTile(
                    header: albums[index].albumArt == null
                        ? Image.asset("assets/icon.png")
                        : Image.file(File(albums[index].albumArt)),
                    footer: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(albums[index].title),
                           Text(albums[index].numberOfSongs)
                        ],
                      ),
                    ),
                    child: Container(),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
