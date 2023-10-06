import 'package:flutter/material.dart';
import 'package:tailored/modules/course/models/material_course.dart';
import 'package:tailored/modules/course/widget/audio_player.dart';
import 'package:tailored/modules/course/widget/video_player.dart';

class ContentItem extends StatelessWidget {
  final Content content;

  const ContentItem({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              textAlign: TextAlign.left,
              content.text ,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(color: Colors.grey,),
          if (content.type == 'IMAGE')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                content.file ?? "",
                width: double.infinity, // Adjust this as needed
                height: 200.0, // Adjust this as needed
                fit: BoxFit.cover, // Adjust this as needed
              ),
            ),
          if (content.type == 'VIDEO')
            VideoPlayerWidget(videoUrl: content.file),
          if (content.type == 'AUDIO')
            AudioPlayerWidget(audioUrl: content.file),
          const Divider(),
        ],
      ),
    );
  }
}
