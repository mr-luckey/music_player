// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:just_audio/just_audio.dart';
// // // import 'package:just_audio/just_audio.dart';
// // import 'package:just_audio_background/just_audio_background.dart';
// // import 'package:just_audio_background/just_audio_background.dart';
// // import 'package:on_audio_query/on_audio_query.dart';
// // import 'package:permission_handler/permission_handler.dart';

// // class PlayerController extends GetxController {
// //   final List<SongModel> data = [];

// //   final audioQuery = OnAudioQuery();
// //   // final audioPlayer = AudioPlayer();
// //   final audioPlayer = AudioPlayer();
// //   RxDouble progress = 0.0.obs;
// //   var playIndex = 0.obs;
// //   var isplaying = false.obs;

// //   var duration = ''.obs;
// //   var position = ''.obs;

// //   var max = 0.0.obs;
// //   var value = 0.0.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     checkPermission();
// //     setupPlayerListeners();
// //   }

// //   void setupPlayerListeners() {
// //     audioPlayer.playerStateStream.listen((playerState) {
// //       if (playerState.processingState == ProcessingState.completed) {
// //         isplaying(false);
// //       }
// //     });
// //   }

// //   updatePosition() {
// //     audioPlayer.durationStream.listen((d) {
// //       duration.value = d.toString().split(".")[0];
// //       max.value = d!.inSeconds.toDouble(); //control the slider
// //     });
// //     audioPlayer.positionStream.listen((p) {
// //       position.value = p.toString().split(".")[0];
// //       value.value = p.inSeconds.toDouble(); //control the slider
// //     });
// //   }

// //   changeDurationnToSeconds(seconds) {
// //     var duration = Duration(seconds: seconds);
// //     audioPlayer.seek(duration);
// //   }

// //   playSongs(String? uri, index) {
// //     playIndex.value = index;
// //     //final List<SongModel> data;
// //     // final song = data[playIndex.value];

// //     // // Create a MediaItem for background audio metadata
// //     // final mediaItem = MediaItem(
// //     //   id: song.id.toString(), // Use the song's unique ID
// //     //   album: song.album ?? "Unknown Album",
// //     //   title: song.data[playIndex.value] ?? "Unknown Title",
// //     //   artist: song.artist ?? "Unknown Artist",
// //     //   // You can also add artwork: Uri here if you have the song's album artwork
// //     // );

// //     try {
// //       audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
// //       JustAudioBackground.init();
// //       final audioSource = AudioSource.uri(Uri.parse(uri));
// //       audioPlayer.setAudioSource(audioSource, preload: true);
// //       audioPlayer.play();
// //       isplaying.value = true;
// //       updatePosition();
// //     } on Exception catch (e) {
// //       debugPrint(e.toString());
// //     }
// //   }

// //   checkPermission() async {
// //     var perm = await Permission.storage.request();
// //     if (perm.isGranted) {
// //     } else {
// //       checkPermission();
// //     }
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:just_audio/just_audio.dart';
// // import 'package:just_audio_background/just_audio_background.dart';
// // import 'package:on_audio_query/on_audio_query.dart';
// // import 'package:permission_handler/permission_handler.dart';

// // class PlayerController extends GetxController {
// //   final audioQuery = OnAudioQuery();
// //   final audioPlayer = AudioPlayer();
// //   RxDouble progress = 0.0.obs;
// //   var playIndex = 0.obs;
// //   var isplaying = false.obs;

// //   var duration = ''.obs;
// //   var position = ''.obs;

// //   var max = 0.0.obs;
// //   var value = 0.0.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     checkPermission();
// //     setupPlayerListeners();
// //   }

// //   void setupPlayerListeners() {
// //     audioPlayer.playerStateStream.listen((playerState) {
// //       if (playerState.processingState == ProcessingState.completed) {
// //         isplaying(false);
// //       }
// //     });
// //     audioPlayer.durationStream.listen((d) {
// //       duration.value = d.toString().split(".")[0];
// //       max.value = d!.inSeconds.toDouble(); //control the slider
// //     });
// //     audioPlayer.positionStream.listen((p) {
// //       position.value = p.toString().split(".")[0];
// //       value.value = p.inSeconds.toDouble(); //control the slider
// //     });
// //   }

// //   changeDurationToSeconds(seconds) {
// //     var duration = Duration(seconds: seconds);
// //     audioPlayer.seek(duration);
// //   }

// //   playSongs(String? uri, index) {
// //     playIndex.value = index;
// //     try {
// //       audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
// //       JustAudioBackground.init();
// //       audioPlayer.play();
// //       isplaying.value = true;
// //     } on Exception catch (e) {
// //       debugPrint(e.toString());
// //     }
// //   }

// //   checkPermission() async {
// //     var perm = await Permission.storage.request();
// //     if (!perm.isGranted) {
// //       await checkPermission();
// //     }
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:permission_handler/permission_handler.dart';

// class PlayerController extends GetxController {
//   final audioQuery = OnAudioQuery();
//   final audioPlayer = AudioPlayer();
//   RxDouble progress = 0.0.obs;
//   var playIndex = 0.obs;
//   var isplaying = false.obs;

//   var duration = ''.obs;
//   var position = ''.obs;

//   var max = 0.0.obs;
//   var value = 0.0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     checkPermission();
//     setupPlayerListeners();
//   }

//   void setupPlayerListeners() {
//     audioPlayer.playerStateStream.listen((playerState) {
//       if (playerState.processingState == ProcessingState.completed) {
//         isplaying(false);
//       }
//     });
//     audioPlayer.durationStream.listen((d) {
//       duration.value = d.toString().split(".")[0];
//       max.value = d!.inSeconds.toDouble(); //control the slider
//     });
//     audioPlayer.positionStream.listen((p) {
//       position.value = p.toString().split(".")[0];
//       value.value = p.inSeconds.toDouble(); //control the slider
//     });
//   }

//   changeDurationToSeconds(seconds) {
//     var duration = Duration(seconds: seconds);
//     audioPlayer.seek(duration);
//   }

//   // playSongs(String? uri, index) {
//   //   playIndex.value = index;
//   //   try {
//   //     audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
//   //     audioPlayer.play();
//   //     isplaying.value = true;
//   //   } on Exception catch (e) {
//   //     debugPrint(e.toString());
//   //   }
//   // }
//   playSongs(String? uri, index) {
//     playIndex.value = index;
//     try {
//       if (uri != null) {
//         audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
//         audioPlayer.play();
//         isplaying.value = true;
//       } else {
//         print("error not found music");
//         // Handle the case where URI is null, perhaps show an error message or take appropriate action.
//       }
//     } on Exception catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   checkPermission() async {
//     var perm = await Permission.storage.request();
//     if (!perm.isGranted) {
//       await checkPermission();
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
//import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final List<SongModel> data = [];

  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  RxDouble progress = 0.0.obs;
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
    // final song = data[playIndex.value];

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
      JustAudioBackground.init();
      final audioSource = AudioSource.uri(Uri.parse(uri!));
      audioPlayer.setAudioSource(audioSource, preload: true);
      audioPlayer.play();
      isplaying.value = true;
      updatePosition();
    } on Exception catch (e) {
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
