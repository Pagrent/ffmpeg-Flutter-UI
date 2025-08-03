import 'dart:io';

import 'package:ffmpegflutterui/utils/confirm_file.dart';
import 'package:flutter/material.dart';

class ConvertPage extends StatefulWidget {
  final List<File> fileList;
  final int selectedFunction;

  const ConvertPage({
    required this.fileList,
    required this.selectedFunction,
    super.key,
  });

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {

  

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        titleTextStyle: TextStyle(
          color: Colors.blueGrey[800],
          fontSize: 30,
        ),
        
        title: Text("Convert"),
        backgroundColor: Colors.deepPurple[100],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.navigate_next),
      ),

    );
  }
}