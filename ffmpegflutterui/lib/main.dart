import 'package:ffmpegflutterui/pages/platform_page.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlatformPage(),
      theme: ThemeData(primarySwatch: Colors.blue),
      
    );
  }
}
