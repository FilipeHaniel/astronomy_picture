import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ApodVideo extends StatefulWidget {
  final String url;

  const ApodVideo({
    required this.url,
    super.key,
  });

  @override
  State<ApodVideo> createState() => _ApodVideoState();
}

class _ApodVideoState extends State<ApodVideo> {
  late String url;

  VideoPlayerController? videoPlayerController;
  YoutubePlayerController? youtubePlayerController;

  VideoPlatform videoPlatfrom = VideoPlatform.standard;

  @override
  void initState() {
    url = widget.url;

    checkVideoPlaform();

    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void disposeControllers() {
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
    }

    if (youtubePlayerController != null) {
      youtubePlayerController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildVideoPlayer();
  }

  void checkVideoPlaform() {
    String youtubeHost = 'https://www.youtube.com';
    String vimeoHost = 'https://vimeo.com';

    if (url.substring(0, youtubeHost.length) == youtubeHost) {
      videoPlatfrom = VideoPlatform.youtube;

      youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url) ?? '',
        flags: const YoutubePlayerFlags(autoPlay: false),
      );

      setState(() {});
    } else if (url.substring(0, vimeoHost.length) == vimeoHost) {
      videoPlatfrom = VideoPlatform.vimeo;
    } else {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  Widget buildVideoPlayer() {
    Widget videoWidget;

    if (videoPlatfrom == VideoPlatform.youtube) {
      videoWidget = YoutubePlayer(controller: youtubePlayerController!);
    } else if (videoPlatfrom == VideoPlatform.vimeo) {
      videoWidget = VimeoVideoPlayer(url: url, autoPlay: false);
    } else {
      if (videoPlayerController!.value.hasError) {
        videoWidget = const Text(
            'Sorry! we cant`t play this video. try open in your browser');
      } else {
        videoWidget = GestureDetector(
          child: Container(
            color: Colors.black,
            child: videoPlayerController!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController!),
                  )
                : Container(),
          ),
          onTap: () {
            videoPlayerController!.value.isPlaying
                ? videoPlayerController!.pause()
                : videoPlayerController!.play();
          },
        );
        videoPlayerController!.play();
      }
    }

    return videoWidget;
  }
}

enum VideoPlatform { standard, youtube, vimeo }
