import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/video_model.dart'; //import model provider sbg STATE MANAGEMENT
import './screens/video_list.dart'; 
import './screens/video_detail.dart'; //untuk menjalankan video yg dipilih

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => VideoProvider(),) //DEFINISIKAN STATE MANAGEMENT AGAR DAPAT DIGUNAKAN DISEMUA SCREEN / PAGE
      ],
      child: MaterialApp(
        title: 'Live Streaming',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: VideoList(), //screen pertama yg diload ketika aplikasi dijalankan yaitu LIST VIDEO
        routes: {
          '/detail': (ctx) => VideoDetail() 
        },
      ),
    );
  }
}