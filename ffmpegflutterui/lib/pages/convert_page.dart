import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpegflutterui/utils/confirm_file.dart';
import 'package:ffmpegflutterui/utils/file_list.dart';
import 'package:ffmpegflutterui/utils/para_list.dart';
import 'package:flutter/material.dart';

class ConvertPage extends StatefulWidget {
  final List<File> fileList;
  final int selectedFunction;
  final int selectedCategory;
  final String? workDir;
  late final inPath = '$workDir/input';
  late final outPath = '$workDir/output';

  ConvertPage({
    required this.fileList,
    required this.selectedFunction,
    required this.workDir,
    super.key,
    required this.selectedCategory,
  });

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {

  String? outputFormat;         //输出格式
  String? outputEncodingFormat; //输出编码格式
  String? audioSampleRate;      //音频采样率
  String? audioChannelCount;    //声道数
  String? volumeMultiplier;     //音量倍数
  String? startTime;            //开始时间
  String? endTime;              //结束时间
  String? duration;             //持续时间
  String? resolution;           //分辨率
  String? frameRate;            //帧速率
  String? rotateAngle;          //旋转角度
  String? timePoint;            //时间点

  void _outFormatFromYoKi(String? outFormat) {
    setState(() {
      outputFormat = outFormat;
    });
  }

  void _outEncodingFormatFromYoKi(String? outEncodingFormat) {
    setState(() {
      outputEncodingFormat = outEncodingFormat;
    });
  }

  void _outSampleRateFromYoKi(String? outSampleRate) {
    setState(() {
      audioSampleRate = outSampleRate;
    });
  }

  void _outChannelCountFromYoKi(String? outChannelCount) {
    setState(() {
      audioChannelCount = outChannelCount;
    });
  }

  void _outMultiplierFromYoKi(String? outMultiplier) {
    setState(() {
      volumeMultiplier = outMultiplier;
    });
  }

  void _outStartTimeFromYoKi(String? outStartTime) {
    setState(() {
      startTime = outStartTime;
    });
  }

  void _outEndTimeFromYoKi(String? outEndTime) {
    setState(() {
      endTime = outEndTime;
    });
  }

  void _outDurationFromYoKi(String? outDuration) {
    setState(() {
      duration = outDuration;
    });
  }

  void _outResolutionFromYoKi(String? outResolution) {
    setState(() {
      resolution = outResolution;
    });
  }

  void _outFrameRateFromYoKi(String? outFrameRate) {
    setState(() {
      frameRate = outFrameRate;
    });
  }

  void _outRotateAngleFromYoKi(String? outRotateAngle) {
    setState(() {
      rotateAngle = outRotateAngle;
    });
  }

  void _outTimePointFromYoKi(String? outTimePoint) {
    setState(() {
      timePoint = outTimePoint;
    });
  }

  Future<void> convertUnit(File file) async {
    final fileFullName = file.path.split('/').last;
    final fileName = fileFullName.split('.').first;
    final inputFormat = fileFullName.split('.').last;
    final String? outputFormat;

    
    if (Platform.isLinux || Platform.isWindows) {
      final executable = Platform.isWindows ? 'ffmpeg.exe' : 'ffmpeg';
      final result = await Process.run(
        executable,
        [
          '-i', '${widget.inPath}/$fileFullName',
          '-c:v', 'copy',
          '-c:a', 'copy',
          '${widget.outPath}/$fileName.mp4'
        ],
        runInShell: Platform.isWindows,
      );
      print('输出: ${result.stdout}');
      if (result.stderr != null && result.stderr.isNotEmpty) {
        print('错误: ${result.stderr}');
      }
      print('退出码: ${result.exitCode}');
    }
  }

  void startConvert() {
    for(int i = 0; i < widget.fileList.length; i++) {
      final file = widget.fileList[i];
      
      convertUnit(file);
    }

    print("结束");
  }

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

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25,),
            YoKi(
              FileList: widget.fileList,
              selectedFunction: widget.selectedFunction,
              outputFormat: _outFormatFromYoKi,
              outputEncodingFormat: _outEncodingFormatFromYoKi,
              audioSampleRate: _outSampleRateFromYoKi,
              audioChannelCount: _outChannelCountFromYoKi,
              volumeMultiplier: _outMultiplierFromYoKi,
              startTime: _outStartTimeFromYoKi,
              endTime: _outEndTimeFromYoKi,
              duration: _outDurationFromYoKi,
              resolution: _outResolutionFromYoKi,
              frameRate: _outFrameRateFromYoKi,
              rotateAngle: _outRotateAngleFromYoKi,
              timePoint: _outTimePointFromYoKi,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startConvert();
        },
        child: Icon(Icons.navigate_next),
      ),

    );
  }
}