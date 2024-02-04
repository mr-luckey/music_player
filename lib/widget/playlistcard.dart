import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/Views/player.dart';
import 'package:music_player/consts/colors.dart';
import 'package:music_player/consts/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/widget/screen_header.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PLayListCard extends StatelessWidget {
  const PLayListCard({
    super.key,
    required this.controller,
  });

  final PlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SectionHeader(title: 'Playlist'),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: FutureBuilder<List<SongModel>>(
                future: controller.audioQuery.querySongs(
                  ignoreCase: true,
                  orderType: OrderType.DESC_OR_GREATER,
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
                        itemCount: 3,
                        // itemCount: snapshot.data!
                        //     .length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => Player(data: snapshot.data!));
                              controller.playSongs(
                                  snapshot.data![index].uri, index);
                            },
                            child: Container(
                              height: 75,
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade800
                                      .withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Row(
                                children: [
                                  QueryArtworkWidget(
                                    id: snapshot.data![index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: Icon(
                                      Icons.music_note,
                                      color: whiteColor,
                                      size: 32,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot
                                                .data![index].displayNameWOExt,
                                            style: ourStyle(
                                                family: bold, size: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "${snapshot.data![index].artist}",
                                            style: ourStyle(
                                                family: regular, size: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  if (controller.playIndex.value == index &&
                                      controller.isplaying.value)
                                    Icon(
                                      Icons.play_circle,
                                      color: whiteColor,
                                      size: 26,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
