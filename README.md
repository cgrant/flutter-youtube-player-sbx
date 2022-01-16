# YouTube Player

This example explores playing youtube videos inside flutter apps. 

The package `youtube_player_flutter` has a sister project called `youtube_player_iframe` both located in the same repo at https://github.com/sarbagyastha/youtube_player_flutter. It's important to note which instructions you're looking at. The top level readme was focused on the iframe variation at time of writing. 

## Controller
A controller is used to retrieve the video and associated metadata. 

```dart
YoutubePlayerController yt = YoutubePlayerController(
    initialVideoId: "FuiafRLTbEQ", 
    flags: YoutubePlayerFlags(
      hideControls: false,
      autoPlay: true,
      mute: false,
    ),
  );
```

The value `initialVideoId` is only used during the creation of the controller. To change the video later you can use the `load()` method as in the setState call below. Alternatively you can queue up a video to play next using the `cue()` method

```dart
FloatingActionButton(
        child: Icon(Icons.video_collection),
        onPressed: () {
          setState(() {
            yt.load("rNgqbV3Ht8I");
          });
        },
      ),
```

Metadata such as __author__ and __title__ are accessed on the  YoutubeMetaData object in the metadata property of the controller. This means that to display a list of videos you'll need to create a controller for each first in order to get the metadata values. The following code maps a controller for each of the IDs provided. 

```dart
final List<YoutubePlayerController> _controllers = ['gQDByCdjUXw','iLnmTe5Q2Qw']
    .map<YoutubePlayerController>(
        (videoId) => YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
            autoPlay: false, 

            ),
        ),
    )
    .toList();
```

The Controller takes `YoutubePlayerFlags` which customize the experience such as  `autoPlay: `, `startAt:`, `endAt:` and others. While the flags sound specific to the Player, they're actually on the controller allowing you to change per video (ie start & end)

## Player

The provides many of the UI oriented components such as default and customizable playback controls. It provides functions for onReady and onEnded, useful for performing actions when the clip is done playing. 

```dart
YoutubePlayer(
    controller: yt,
    onEnded: (metaData) {
        yt.seekTo(Duration(seconds: 0));
        yt.pause();
    }, 
),
```
The Player takes a controller as input for the video source. It would make sense based on this model to set a new controller on the player to change the video rather than call cue or load on the controller, though I'm not sure if thats possible or not and haven't tried it yet. 

A static `getThumbnail` value is available on the player

## Builder

A `YoutubePlayerBuilder` widget is available that takes a player as a parameter. It also requires a `builder: (context, player) {}` parameter which allows you to build a mutable widget, which is required for full screen viewings. 

```dart
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
```


## Android Configuration

requires minSdk 20

update android/app/build.gradle:
```
android {
  defaultConfig {
    minSdkVersion 20
  }
}
```

## Web

Not supported use the iframe version instead