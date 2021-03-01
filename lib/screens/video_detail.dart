import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart'; //mengload library webview utk meng-embed video
import '../models/video_model.dart'; //MODEL PROVIDER

class VideoDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final data =
        Provider.of<VideoProvider>(context, listen: false).findVideo(id); 
    
    return Center(
      child: WebviewScaffold(
        url: "https://www.youtube.com/embed/${data.videoId}",
      ),
    );
  }
}