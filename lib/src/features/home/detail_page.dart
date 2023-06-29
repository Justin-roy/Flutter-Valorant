import 'package:flutter/material.dart';

import 'package:flutter_valorant/src/style/text_theme.dart';
import 'package:flutter_valorant/src/utils/cached_network_image/network_image_helper.dart';

import '../../utils/audio/audio_online_player.dart';

class DetailPage extends StatefulWidget {
  final String imageUri;
  final String audioUri;
  final String characterName;
  final String description;
  final String displayIcon;
  final String bgImage;
  final List<String> backgroundGradientColors;

  const DetailPage({
    Key? key,
    required this.imageUri,
    required this.audioUri,
    required this.characterName,
    required this.description,
    required this.displayIcon,
    required this.bgImage,
    required this.backgroundGradientColors,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: 'background',
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ...List.generate(
                      widget.backgroundGradientColors.length,
                      (cIndex) => Color(
                        int.parse(
                          widget.backgroundGradientColors[cIndex],
                          radix: 16,
                        ),
                      ),
                    ),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Stack(
                    children: [
                      NetworkImageHelper(
                        imageUrl: widget.bgImage,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        child: Hero(
                          tag: widget.characterName,
                          child: NetworkImageHelper(
                            imageUrl: widget.imageUri,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.characterName,
                  style: TextThemeValorant.valorantStyle
                      .copyWith(fontSize: 32, letterSpacing: 1.5),
                ),
                Flexible(
                  child: Text(
                    widget.description,
                    style: TextThemeValorant.valorantStyle
                        .copyWith(letterSpacing: 1.5),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              onPressed: () async =>
                  await AudioOnlinePlayer.playOnliveAudio(widget.audioUri),
              icon: const Icon(
                Icons.volume_up,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {},
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.displayIcon),
              ),
            ),
          )
        ],
      ),
    );
  }
}
