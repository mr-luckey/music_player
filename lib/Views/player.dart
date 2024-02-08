import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/consts/colors.dart';
import 'package:music_player/consts/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:siri_wave/siri_wave.dart';

import '../controllers/animation-controller.dart';

class Player extends StatefulWidget {
  final List<SongModel> data;
  Player({
    super.key,
    required this.data,
  });

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);

  // Create an animation with value of type "double"
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();



    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.0),
                ],
                stops: [
                  0.0,
                  0.4,
                  0.6
                ]).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.deepPurple.shade700,
                  Colors.deepPurple.shade800,
                ])),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RotationTransition(
                    turns: _animation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1000)),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: sliderColor, width: 100),
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            height: 300,
                            width: 300,
                          ),
                        ),
                        ClipOval(
                          child: QueryArtworkWidget(
                              id: widget.data[controller.playIndex.value].id,
                              type: ArtworkType.AUDIO,
                              artworkHeight: double.infinity,
                              artworkWidth: double.infinity,
                              nullArtworkWidget: Icon(
                                Icons.music_note,
                                color: sliderColor,
                                size: 48,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Text(
                      widget.data[controller.playIndex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:
                          ourStyle(color: whiteColor, family: bold, size: 24),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Obx(
                    () => Text(
                      widget.data[controller.playIndex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourStyle(
                          color: whiteColor, family: regular, size: 20),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Text(
                          controller.position.value,
                          style: ourStyle(color: whiteColor),
                        ),

                        Expanded(
                            child: Slider(
                                thumbColor: sliderColor,
                                inactiveColor: whiteColor,
                                activeColor: sliderColor,
                                min: Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(), //control the slider
                                max: controller.max.value, //control the slider
                                value:
                                    controller.value.value, //control the slider
                                onChanged: (newValue) {
                                  controller.changeDurationnToSeconds(
                                      //control the slider
                                      newValue.toInt());
                                  newValue = newValue;
                                })),
                        Text(
                          controller.duration.value,
                          style: ourStyle(color: whiteColor),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        IconData iconData;
                        String modeText;
                        switch (controller.playMode.value) {
                          case PlayMode.loopAll:
                            iconData = Icons.repeat;
                            modeText = "Loop All";
                            break;
                          case PlayMode.shuffle:
                            iconData = Icons.shuffle;
                            modeText = "Shuffle";

                            break;
                          case PlayMode.repeatCurrent:
                            iconData = Icons.repeat_one;
                            modeText = "Current";
                            break;
                          case PlayMode.inOrder:
                            iconData = Icons.playlist_play;
                            modeText = "In Order";
                            break;
                          default:
                            iconData = Icons.repeat; // Default icon
                            modeText = "Loop All"; // Default text
                            break;
                        }

                        return Row(
                          mainAxisSize: MainAxisSize
                              .min, // To keep the Row as tight as possible
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.togglePlayMode();
                              },
                              icon: Icon(iconData, color: whiteColor),
                            ),
                            Obx(() => Visibility(
                                  visible: controller.isModeTextVisible
                                      .value, // Controlled by the state
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                    margin: EdgeInsets.only(left: 8),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      modeText,
                                      style: TextStyle(color: whiteColor),
                                    ),
                                  ),
                                )),
                          ],
                        );
                      }),
                      IconButton(
                          onPressed: () {
                            controller.playSongs(
                                widget.data[controller.playIndex.value - 1].uri,
                                controller.playIndex.value - 1);
                          },
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            size: 40,
                            color: whiteColor,
                          )),
                      Obx(
                        () => CircleAvatar(
                          radius: 35,
                          backgroundColor: whiteColor,
                          child: Transform.scale(
                            scale: 2.5,
                            child: IconButton(
                                onPressed: () {
                                  if (controller.isplaying.value) {
                                    _controller.stop();
                                    controller.audioPlayer.pause();
                                    controller.isplaying(false);
                                  } else {
                                    controller.audioPlayer.play();
                                    _controller.repeat();
                                    controller.isplaying(true);
                                  }
                                },
                                icon: controller.isplaying.value
                                    ? Icon(
                                        Icons.pause,
                                        color: Colors.deepPurple,
                                      )
                                    : Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.deepPurple,
                                      )),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.playSongs(
                                widget.data[controller.playIndex.value + 1].uri,
                                controller.playIndex.value + 1);
                          },
                          icon: Icon(
                            Icons.skip_next_rounded,
                            size: 40,
                            color: whiteColor,
                          )),
                      IconButton(
                          onPressed: () {
                            controller.audioPlayer.seek(Duration.zero);

                            controller.isplaying(true);
                          },
                          icon: Image.asset(
                            ("assets/images/refresh.png"),
                            color: Colors.white,
                            height: 20,
                            width: 20,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
