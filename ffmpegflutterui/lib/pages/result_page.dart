import 'dart:io';

import 'package:ffmpegflutterui/utils/file_result.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ResultPage extends StatefulWidget {
  final List<bool> fileStatus;
  final List<File> fileList;
  const ResultPage({
    super.key,
    required this.fileList,
    required this.fileStatus,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  static Future<String?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return '/storage/emulated/0/Download/FFmpegFlutterUI'; // Android 下载目录
    } else if (Platform.isLinux) {
      final home = Platform.environment['HOME'];
      return '$home/Downloads/FFmpegFlutterUI'; // Linux 下载目录
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        titleTextStyle: TextStyle(
          color: Colors.blueGrey[800],
          fontSize: 30,
        ),
        
        title: Text("Result"),
        backgroundColor: Colors.deepPurple[100],
        
      ),

      body: ListView.builder(
        itemCount: widget.fileList.length,
        itemBuilder: (context, index){
          return FileResult(
            fileName: widget.fileList[index].path.split('/').last,
            isSuccess: widget.fileStatus[index],
          );
        },
      ),
    );
  }
}