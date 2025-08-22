import 'dart:ffi';
import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:ffmpegflutterui/pages/result_page.dart';
import 'package:ffmpegflutterui/utils/file_list.dart';
import 'package:ffmpegflutterui/utils/para_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:process_run/shell.dart';

class ConvertPage extends StatefulWidget {
  final List<File> fileList;
  final int selectedFunction;
  final int selectedCategory;
  final String? workDir;
  late final inPath = '$workDir/input';
  late String outPath = '$workDir/output';

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

  String? finalCommand;
  String? currentTime;

  String currentFileName = "Initializing";
  int total = 0;
  int success = 0;
  int finished = 0;
  int failed = 0;

  bool pressedRun = false;

  List<bool> fileStatus = [];
  List<String> generatedFile = [];

  void fileStatusInit() {
    for(int i = 0; i < 100; i++) {
      fileStatus.add(false);
    }
  }

  void getCurrentTime() {
    currentTime = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
  }
  Future<void> createTimeDir() async {
    await Directory('${widget.outPath}/$currentTime').create(recursive: true);
  }

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

  void goToResult(List<bool> status, List<File> fuckList) {
    if(finished == total) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            fileList: fuckList,
            fileStatus: status,
          )
        )
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please wait for the process to finish.")
        )
      );
    }
  }

  void getCommand(File file) {
    if(Platform.isAndroid) {
      widget.outPath = "/storage/emulated/0/Download/FFmpegFlutterUI";
    }
    final fileFullName = file.path.split('/').last;
    final fileName = fileFullName.split('.').first;
    final fileFormat = fileFullName.split('.').last;
    switch (widget.selectedFunction) {
      case 1:
        finalCommand = '-i "${widget.inPath}/$fileFullName" "${widget.outPath}/$fileName.ConvertFormat.$outputFormat"';
      case 2:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -c:v $outputEncodingFormat "${widget.outPath}/$fileName.Transcoding-$outputEncodingFormat.$outputFormat"';
      case 3:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -ss $startTime -to $endTime "${widget.outPath}/$fileName.Trim.$fileFormat"';
      case 4:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -s $resolution "${widget.outPath}/$fileName.AdjustResolution-$resolution.$fileFormat"';
      case 5:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -r $frameRate "${widget.outPath}/$fileName.AdjustFPS-$frameRate.$fileFormat"';
      case 6:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -vf "rotate=$rotateAngle*PI/180,pad=width=ceil(iw/2)*2:height=ceil(ih/2)*2" -c:a copy "${widget.outPath}/$fileName.Rotate-$rotateAngle.$fileFormat"';
      case 7:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -an "${widget.outPath}/$fileName.RemoveAudio.$fileFormat"';
      case 8:
        if(outputFormat == "mp3") {
          finalCommand = '-i "${widget.inPath}/$fileFullName" -vn -c:a libmp3lame "${widget.outPath}/$fileName.ExtractAudio.$outputFormat"';
        }
        if(outputFormat == "aac" || outputFormat == "m4a") {
          finalCommand = '-i "${widget.inPath}/$fileFullName" -vn -c:a aac "${widget.outPath}/$fileName.ExtractAudio.$outputFormat"';
        }
        if(outputFormat == "wav" || outputFormat == "aiff" || outputFormat == "aif") {
          finalCommand = '-i "${widget.inPath}/$fileFullName" -vn -c:a pcm_s16le "${widget.outPath}/$fileName.ExtractAudio.$outputFormat"';
        }
        if(outputFormat == "flac") {
          finalCommand = '-i "${widget.inPath}/$fileFullName" -vn -c:a flac "${widget.outPath}/$fileName.ExtractAudio.$outputFormat"';
        }
        if(outputFormat == "ogg") {
          finalCommand = '-i "${widget.inPath}/$fileFullName" -vn -c:a libvorbits "${widget.outPath}/$fileName.ExtractAudio.$outputFormat"';
        }
        if(outputFormat == "opus") {
          finalCommand = '-i "${widget.inPath}/$fileFullName" -vn -c:a libopus "${widget.outPath}/$fileName.ExtractAudio.$outputFormat"';
        }
      case 9:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -ss $timePoint -vframes 1 "${widget.outPath}/$fileName.ScreenShot-$timePoint.$outputFormat"';
      case 11:
        finalCommand = '-i "${widget.inPath}/$fileFullName" "${widget.outPath}/$fileName.ConvertFormat.$outputFormat"';
      case 12:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -s $resolution "${widget.outPath}/$fileName.AdjustResolution-$resolution.$fileFormat"';
      case 13:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -vf "rotate=$rotateAngle*PI/180" "${widget.outPath}/$fileName.Rotate-$rotateAngle.$fileFormat"';
      case 21:
        finalCommand = '-i "${widget.inPath}/$fileFullName" "${widget.outPath}/$fileName.ConvertFormat.$outputFormat"';
      case 22:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -c:a $outputEncodingFormat "${widget.outPath}/$fileName.Transcoding.$outputFormat"';
      case 23:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -af volume=$volumeMultiplier "${widget.outPath}/$fileName.AdjustVolume-${volumeMultiplier}x.$fileFormat"';
      case 24:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -ss $startTime -to $endTime "${widget.outPath}/$fileName.Trim.$fileFormat"';
      case 25:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -ar $audioSampleRate "${widget.outPath}/$fileName.ConvertSampleRate-$audioSampleRate.$fileFormat"';
      case 26:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -ac $audioChannelCount "${widget.outPath}/$fileName.AdjustChannelCount-$audioChannelCount.$outputFormat"';
      case 31:
        finalCommand = '-i "${widget.inPath}/$fileFullName" -vf "fps=$frameRate" -loop 0 "${widget.outPath}/$fileName.VideoToGIF.gif"';
      case 32:
        getCurrentTime();
        finalCommand = '-i "${widget.inPath}/$fileFullName" -r $frameRate "${widget.outPath}/ExtractFrame$currentTime/$fileName.ExtractFrame%03d.$outputFormat"';
    }
    print(finalCommand);
  }

  List<String> splitCommand(String command) {
    final regex = RegExp(r'"[^"]+"|\S+');
    return regex
        .allMatches(command)
        .map((m) => m.group(0)!)
        .toList();
  }

  Future<void> convertUnit(File file, int num) async {
    setState(() {
      currentFileName = file.path.split('/').last;
    });
    getCommand(file);
    if (Platform.isLinux) {
      bool status = false;
      var shell = new Shell();
      try {
        final result = await shell.run('/usr/bin/ffmpeg $finalCommand');
        for(var processResult in result) {
          print('STDOUT: ${processResult.stdout}');
          print('STDERR: ${processResult.stderr}');
          print('EXIT CODE: ${processResult.exitCode}');
          if(processResult.exitCode == 0) {
            setState(() {
              success++;
              status = true;
            });
          }
        }
      } catch(e) {
        print('catch(e): $e');
      }
      setState(() {
        finished++;
        failed = finished - success;
        fileStatus[num] = status;
      });
    }

    else if(Platform.isAndroid || Platform.isIOS ||Platform.isMacOS) {
      bool status = false;
      try {
        final session = await FFmpegKit.execute(finalCommand!);
        final returnCode = await session.getReturnCode();
      
        if (ReturnCode.isSuccess(returnCode)) {
          setState(() {
            print('转换成功！');
            success++;
            finished++;
            status = true;
          });
        } else if (ReturnCode.isCancel(returnCode)) {
          setState(() {
            print('操作取消');
            failed++;
            finished++;
            status = false;
          });
        } else {
          setState(() async {
            print('转换失败: ${await session.getFailStackTrace()}');
            failed++;
            finished++;
            status = false;
          });
        }
      } catch (e) {
        print('发生异常: $e');
      }
      fileStatus[num] = status;
    }
  }

  void startConvert() {

    if (pressedRun == false) {
      pressedRun = true;
      for(int i = 0; i < widget.fileList.length; i++) {
        final file = widget.fileList[i];
        convertUnit(file, i);
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Do not press the button multiple times.")
        )
      );
    }

    print("结束");
  }

  @override

  Widget build(BuildContext context) {
    total = widget.fileList.length;
    fileStatusInit();
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
            SizedBox(height: 25,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.deepPurple.shade50),
              ),
              onPressed: startConvert,
              child: Text(
                "Run",
                style: TextStyle(
                  fontSize: 15
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width / 2 + 35,
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text(
                    "Progress",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: [
                        Text(currentFileName),
                        LinearProgressIndicator(
                          
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.cancel,
                                  color: Colors.red[700],
                                ),
                                Text('$failed'),
                              ],
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width / 8,),
                            Column(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                Text('$success'),
                              ],
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width / 8,),
                            Column(
                              children: [
                                Icon(
                                  Icons.trip_origin,
                                  color: Colors.blue,
                                ),
                                Text('$total'),
                              ],
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: (finished)/total,
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
          goToResult(fileStatus, widget.fileList);
        },
        child: Icon(Icons.navigate_next),
      ),

    );
  }
}