import 'package:flutter/material.dart';
import 'package:music_player/consts/colors.dart';
import 'package:music_player/consts/text_styles.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final SongModel data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                        id: data.id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: double.infinity,
                        artworkWidth: double.infinity,
                        nullArtworkWidget: Icon(
                          Icons.music_note,
                          color: whiteColor,
                          size: 48,
                        )))),
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
              child: Column(
                children: [
                  Text(
                    "Music name",
                    style: ourStyle(color: bgDarkColor, family: bold, size: 24),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Artist name",
                    style:
                        ourStyle(color: bgDarkColor, family: regular, size: 20),
                  ),
                  Row(
                    children: [
                      Text(
                        "0.0",
                        style: ourStyle(color: bgDarkColor),
                      ),
                      Expanded(
                          child: Slider(
                              thumbColor: sliderColor,
                              inactiveColor: bgColor,
                              activeColor: sliderColor,
                              value: 0.0,
                              onChanged: (newValue) {})),
                      Text(
                        "04:00",
                        style: ourStyle(color: bgDarkColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            size: 40,
                            color: bgDarkColor,
                          )),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: bgDarkColor,
                        child: Transform.scale(
                          scale: 2.5,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.play_arrow_rounded,
                                color: whiteColor,
                              )),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_next_rounded,
                            size: 40,
                            color: bgDarkColor,
                          )),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
