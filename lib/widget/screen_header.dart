import 'package:flutter/material.dart';
import 'package:music_player/Views/view_screen.dart';
import 'package:music_player/controllers/player_controller.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.action = 'View More',
  });
  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => ViewScreen(
                            controller: PlayerController(),
                          )));
            },
            child: Text(
              action,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ))
      ],
    );
  }
}
