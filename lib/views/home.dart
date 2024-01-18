import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/consts/colors.dart';
import 'package:music_player/consts/text_styles.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/views/palyer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: whiteColor,
                ))
          ],
          leading: Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
          title:
              Text("Audio Player", style: ourStyle(family: 'bold', size: 18)),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL,
            ),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                // print(snapshot.data);
                return Center(
                    child: Text(
                  "No song found",
                  style: ourStyle(),
                ));
              } else {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Obx(
                              () => ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                tileColor: bgColor,
                                title: Text(
                                  snapshot.data![index].displayNameWOExt,
                                  style: ourStyle(family: bold, size: 15),
                                ),
                                subtitle: Text(
                                  "${snapshot.data![index].artist}",
                                  style: ourStyle(family: regular, size: 12),
                                ),
                                leading: QueryArtworkWidget(
                                    id: snapshot.data![index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: Icon(
                                      Icons.music_note,
                                      color: whiteColor,
                                      size: 32,
                                    )),
                                trailing: controller.playIndex.value == index &&
                                        controller.isplaying.value
                                    ? Icon(
                                        Icons.play_arrow,
                                        color: whiteColor,
                                        size: 26,
                                      )
                                    : null,
                                onTap: () {
                                  Get.to(() => Player(
                                        data: snapshot.data![index],
                                      ));
                                  // controller.playSongs(
                                  //     snapshot.data![index].uri, index);
                                },
                              ),
                            ));
                      }),
                );
              }
            }));
  }
}
// 