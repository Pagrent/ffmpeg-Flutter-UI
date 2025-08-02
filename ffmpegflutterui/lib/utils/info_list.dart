import 'package:flutter/material.dart';

class InfoList extends StatefulWidget {
  final int? selectedFunction;

  InfoList({
    super.key,
    required this.selectedFunction,
  });

  @override
  State<InfoList> createState() => _InfoListState();
}

class _InfoListState extends State<InfoList> {
  @override
  Widget build(BuildContext context) {

    switch(widget.selectedFunction) {
      case 1: return Text("Convert video to different format");
      case 2: return Text("Change video encoding format");
      case 3: return Text("Cut video segment");
      case 4: return Text("Change video resolution");
      case 5: return Text("Change video frame rate");
      case 6: return Text("Rotate video orientation");
      case 7: return Text("Remove audio from video");
      case 8: return Text("Extract audio from video");
      case 9: return Text("Capture still image from video");
      case 21: return Text("Convert audio to different format");
      case 22: return Text("Change audio encoding format");
      case 23: return Text("Adjust audio volume level");
      case 24: return Text("Cut audio segment");
      case 25: return Text("Change audio sample rate");
      case 26: return Text("Change number of audio channels");
      case 31: return Text("Create animated GIF from video");
      case 32: return Text("Extract all frames from video");
    }

    return Text(
      "None"
    );
  }
}