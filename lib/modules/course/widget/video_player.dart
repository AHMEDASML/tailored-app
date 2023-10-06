
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown
        if (mounted) {
          setState(() {
            // _controller.play(); // You can autoplay if needed
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : const Center(child: CircularProgressIndicator()),
        ),
        if (!_controller.value.isPlaying) // Show play button if not playing
          IconButton(
            icon: const Icon(Icons.play_arrow,color: Colors.red,),
            iconSize: 64.0,
            onPressed: () {
              setState(() {
                _controller.play();
              });
            },
          ),
        if (_controller.value.isPlaying) // Show pause button if playing
          IconButton(
            icon: const Icon(Icons.pause,color: Colors.red,),
            iconSize: 64.0,
            onPressed: () {
              setState(() {
                _controller.pause();
              });
            },
          ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}