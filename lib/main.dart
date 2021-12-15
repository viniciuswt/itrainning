import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itrainning/home.dart';
//import 'package:itrainning/video_info.dart';

//import 'home.dart';
//import 'video_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
