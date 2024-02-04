import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/Views/home.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main()async {
     WidgetsFlutterBinding.ensureInitialized();
 await JustAudioBackground.init(
    androidNotificationChannelId: 'com.musicplayer.id.channel.audio',
    androidNotificationChannelName: 'Audio Playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Player_music',
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)),
      home: MyHomePage(),
    );
  }
}
