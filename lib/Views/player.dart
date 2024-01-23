import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/consts/colors.dart';
import 'package:music_player/consts/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                  child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: QueryArtworkWidget(
                          id: data[controller.playIndex.value].id,
                          type: ArtworkType.AUDIO,
                          artworkHeight: double.infinity,
                          artworkWidth: double.infinity,
                          nullArtworkWidget: Icon(
                            Icons.music_note,
                            color: whiteColor,
                            size: 48,
                          )))),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      data[controller.playIndex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:
                          ourStyle(color: bgDarkColor, family: bold, size: 24),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      data[controller.playIndex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourStyle(
                          color: bgDarkColor, family: regular, size: 20),
                    ),
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            controller.position.value,
                            style: ourStyle(color: bgDarkColor),
                          ),
                          Expanded(
                              child: Slider(
                                  thumbColor: sliderColor,
                                  inactiveColor: bgColor,
                                  activeColor: sliderColor,
                                  min: Duration(seconds: 0)
                                      .inSeconds
                                      .toDouble(), //control the slider
                                  max:
                                      controller.max.value, //control the slider
                                  value: controller
                                      .value.value, //control the slider
                                  onChanged: (newValue) {
                                    controller.changeDurationnToSeconds(
                                        //control the slider
                                        newValue.toInt());
                                    newValue = newValue;
                                  })),
                          Text(
                            controller.duration.value,
                            style: ourStyle(color: bgDarkColor),
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
                              color: bgDarkColor,
                            )),
                        Obx(
                          () => CircleAvatar(
                            radius: 35,
                            backgroundColor: bgDarkColor,
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
                                          color: whiteColor,
                                        )
                                      : Icon(
                                          Icons.play_arrow_rounded,
                                          color: whiteColor,
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
                              color: bgDarkColor,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )),
            // )
          ],
        ),
      ),
    );
  }
}
