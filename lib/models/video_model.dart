import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http; //import hhtp library
import 'dart:convert';

//untuk mendefinisikan format data yg diinginkan
class VideoModel {
  //mendefinisikan variable yg dibutuhkan
  final String videoId;
  final String title;
  final String channelId;
  final String channelTitle;
  final String image;

  //membuat contructor, agar pada saat class ini digunakan maka wajib mengirimkan data yg diminta dicontructor
  VideoModel({
    @required this.videoId,
    @required this.title,
    @required this.channelId,
    @required this.channelTitle,
    @required this.image,
  });

 
  factory VideoModel.fromJson(Map<String, dynamic> json) {
//mengubah format data sesuai yg ada di contructor
    return VideoModel(
      videoId: json['id']['videoId'],
      title: json['snippet']['title'],
      channelId: json['snippet']['channelId'],
      channelTitle: json['snippet']['channelTitle'],
      image: json['snippet']['thumbnails']['high']['url'],
    );
  }
}

//STATE MANAGEMENT
class VideoProvider with ChangeNotifier {
  List<VideoModel> _items = []; //definisikan variable untuk menampung data video

  List<VideoModel> get items {
    return [..._items];
  }

  //membuat fungsi utk mengambil api dr yt
  Future<void> getVideo(String requestKeyword) async {
    final keyword = 'ustadz ' + requestKeyword; 
    final apiToken = 'AIzaSyBphzU5FojqYTJWsuKzE2vHKjbD7SyGUA4'; 
    
    final url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&eventType=live&relevanceLanguage=id&maxResults=25&q=$keyword&type=video&key=$apiToken';
    final response = await http.get(url); //KIRIM REQUEST
    final extractData = json.decode(response.body)['items'];

    if (extractData == null) {
      return;
    }

    _items =
        extractData.map<VideoModel>((i) => VideoModel.fromJson(i)).toList();
    notifyListeners(); 
  }


  VideoModel findVideo(String videoId) {
    return _items.firstWhere((q) => q.videoId == videoId);
  }
}