import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/consts/colors.dart';
import 'package:music_player/consts/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    // final waveformPoints = <int>[
    //   0,
    //   1,
    //   2,
    //   3,
    //   4,
    //   6,
    //   5,
    //   8,
    //   9,
    //   10,
    //   15,
    //   13,
    //   0,
    //   20,
    //   15
    // ]; 

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
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: QueryArtworkWidget(
                              id: data[controller.playIndex.value].id,
                              type: ArtworkType.AUDIO,
                              artworkHeight: double.infinity,
                              artworkWidth: double.infinity,
                              nullArtworkWidget: Icon(
                                Icons.music_note,
                                color: whiteColor,
                                size: 48,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Text(
                      data[controller.playIndex.value].displayNameWOExt,
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
                      data[controller.playIndex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourStyle(
                          color: whiteColor, family: regular, size: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Row(
                      children: [
                  Text(
                    controller.position.value,
                    style: ourStyle(color: whiteColor),
                  ),

                  // Obx(
                  //   () => GestureDetector(
                  //     onHorizontalDragUpdate: (details) {
                  //       // Calculate the new position in the song
                  //       final renderBox =
                  //           context.findRenderObject() as RenderBox;
                  //       final localPoint =
                  //           renderBox.globalToLocal(details.globalPosition);
                  //       final newProgress =
                  //           localPoint.dx / renderBox.size.width;
                  //       // Seek the audio player to the new position
                  //       final newDuration = Duration(
                  //         seconds: (newProgress * controller.max.value).toInt(),
                  //       );
                  //       controller.audioPlayer.seek(newDuration);
                  //     },
                  //     child: CustomPaint(
                  //       size: Size(double.infinity,
                  //           100), // Set a fixed height for the waveform
                  //       painter: WaveformPainter(
                  //         waveformPoints: waveformPoints,
                  //         progress:
                  //             controller.value.value / controller.max.value,
                  //       ),
                  //     ),
                  //   ),
                  // ),

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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            controller.playSongs(
                                data[controller.playIndex.value - 1].uri,
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
                                    controller.audioPlayer.pause();
                                    controller.isplaying(false);
                                  } else {
                                    controller.audioPlayer.play();
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
                                data[controller.playIndex.value + 1].uri,
                                controller.playIndex.value + 1);
                          },
                          icon: Icon(
                            Icons.skip_next_rounded,
                            size: 40,
                            color: whiteColor,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));

    // )
  }
}
