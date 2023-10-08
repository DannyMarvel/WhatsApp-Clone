import 'package:danny_chats/features/landing/auth/chats/widgets/video_player_item.dart';
import 'package:flutter/material.dart';

import '../../../../../common/enums/message_enum.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);
//This Part tells us the type we want to display
//Either Text, Video, image etc
  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();

    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.audio
            ? StatefulBuilder(builder: (context, setState) {
                return IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 100,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await audioPlayer.play(UrlSource(message));
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                  ),
                );
              })
            : type == MessageEnum.video
                ? VideoPlayerItem(
                  //Add  Cached Video player Plugin
                    videoUrl: message,
                  )
                : type == MessageEnum.gif
                    ? CachedNetworkImage(
//Add CachedNetworkImage Plugin Package                      
//CachedNetworkImage enables us to get the image direclty from the net
//Instead of displaying the Image url link                      
                        imageUrl: message,
                      )
                    : CachedNetworkImage(
              //Add in Pubspec.Yaml        
                        imageUrl: message,
                      );
  }
}
