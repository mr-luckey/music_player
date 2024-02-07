import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

enum PlayMode { loopAll, shuffle, repeatCurrent, inOrder }

class PlayerController extends GetxController {
  var playMode = PlayMode.loopAll.obs;
  var isModeTextVisible = false.obs;

  var songs = <SongModel>[].obs;

  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  //RxDouble progress = 0.0.obs;
  var playIndex = 0.obs;
  var isplaying = false.obs;

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    setupPlayerListeners();
    setupSongCompletionListener();
    //playNextSongLoopAll();
  }

  void togglePlayMode() {
    PlayMode nextMode;
    switch (playMode.value) {
      case PlayMode.loopAll:
        nextMode = PlayMode.shuffle;
        break;
      case PlayMode.shuffle:
        nextMode = PlayMode.repeatCurrent;
        break;
      case PlayMode.repeatCurrent:
        nextMode = PlayMode.inOrder;
        break;
      case PlayMode.inOrder:
      default:
        nextMode = PlayMode.loopAll;
        break;
    }
    isModeTextVisible.value = true;
    Future.delayed(Duration(seconds: 1), () {
      isModeTextVisible.value = false;
    });
    playMode.value = nextMode;
  }

  void setupSongCompletionListener() {
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        switch (playMode.value) {
          case PlayMode.loopAll:
            playNextSongLoopAll();
            break;
          case PlayMode.shuffle:
            playRandomSong();
            break;
          case PlayMode.repeatCurrent:
            replayCurrentSong();
            break;
          case PlayMode.inOrder:
            playNextSongInOrder();
            break;
        }
      }
    });
  }

  void playNextSongLoopAll() {
    playIndex.value =
        (playIndex.value + 1) % songs.length; // Loop back to 0 if at the end
    playCurrentSong();
  }

  void playRandomSong() {
    Random rnd = Random();
    playIndex.value = rnd.nextInt(songs.length);
    playCurrentSong();
  }

  void replayCurrentSong() {
    playCurrentSong();
  }

  void playNextSongInOrder() {
    if (playIndex.value < songs.length - 1) {
      playIndex.value += 1;
    } else {
      // To stop playback:
      // audioPlayer.stop();
      // OR to loop to the first song:
      playIndex.value = 0;
    }
    playCurrentSong();
  }

  void playCurrentSong() {
    if (songs.isNotEmpty &&
        playIndex.value >= 0 &&
        playIndex.value < songs.length) {
      var songUri = songs[playIndex.value].data;

      audioPlayer.setUrl(songUri);
    }
  }

  void setupPlayerListeners() {
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        isplaying(false);
      }
    });
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble(); //control the slider
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble(); //control the slider
    });
  }

  changeDurationnToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  playSongs(String? uri, index) {
    playIndex.value = index;
    //final List<SongModel> data;
    //  final song = songs[playIndex.value];

    // // Create a MediaItem for background audio metadata
    // final mediaItem = MediaItem(
    //   id: song.id.toString(), // Use the song's unique ID
    //   album: song.album ?? "Unknown Album",
    //   title: song.data[playIndex.value] ?? "Unknown Title",
    //   artist: song.artist ?? "Unknown Artist",
    //   // You can also add artwork: Uri here if you have the song's album artwork
    // );

    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      //JustAudioBackground.init();
      //final audioSource = AudioSource.uri(Uri.parse(uri!));
      //audioPlayer.setAudioSource(audioSource, preload: true);
      audioPlayer.play();

      audioPlayer.setUrl(uri);
      isplaying.value = true;
      updatePosition();
    } on Exception catch (e) {
      print('Error playing audio: $e');
      debugPrint(e.toString());
    }
  }

  checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }
}
