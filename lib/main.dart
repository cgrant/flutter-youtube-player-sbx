import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  YoutubePlayerController yt = YoutubePlayerController(
    initialVideoId: "FuiafRLTbEQ", //Add videoID.

    flags: YoutubePlayerFlags(
      hideControls: false,
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YTPlayer(yt: yt),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.video_collection),
        onPressed: () {
          setState(() {
            yt.load("rNgqbV3Ht8I");
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class YTPlayer extends StatelessWidget {
  const YTPlayer({
    Key? key,
    required this.yt,
  }) : super(key: key);

  final YoutubePlayerController yt;

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: yt,
        onEnded: (metaData) {
          yt.seekTo(Duration(seconds: 0));
          yt.pause();
        },
      ),
      builder: (context, player) {
        return Scaffold(body: player);
      },
    );
  }
}
