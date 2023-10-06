import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    await _audioPlayer.setSourceUrl(widget.audioUrl);
    _audioPlayer.onPlayerComplete.listen((event) {
      // Audio playback completed, you can handle it here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(_audioPlayer.state == PlayerState.playing
              ? Icons.pause
              : Icons.play_arrow),
          onPressed: () {
            if (_audioPlayer.state == PlayerState.playing) {
              _audioPlayer.pause();
            } else {
              _audioPlayer.play(UrlSource(widget.audioUrl));
            }
          },
        ),
        
        const Text(
          'Audio Title', // Replace with your audio title logic
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _audioPlayer.release();
    _audioPlayer.dispose();
    super.dispose();
  }
}
