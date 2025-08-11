import 'dart:io';

import 'package:ffmpegflutterui/pages/settings_page.dart';
import 'package:ffmpegflutterui/utils/3choose2_list.dart';
import 'package:ffmpegflutterui/utils/timepoint_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YoKi extends StatefulWidget {
  List<File> FileList;
  int selectedFunction;

  ValueChanged<String?> outputFormat;         //输出格式
  ValueChanged<String?> outputEncodingFormat; //输出编码格式
  ValueChanged<String?> audioSampleRate;      //音频采样率
  ValueChanged<String?> audioChannelCount;    //声道数
  ValueChanged<String?> volumeMultiplier;     //音量倍数
  ValueChanged<String?> startTime;            //开始时间
  ValueChanged<String?> endTime;              //结束时间
  ValueChanged<String?> duration;             //持续时间
  ValueChanged<String?> resolution;           //分辨率
  ValueChanged<String?> frameRate;            //帧速率
  ValueChanged<String?> rotateAngle;          //旋转角度
  ValueChanged<String?> timePoint;            //时间点

  YoKi({
    super.key,
    required this.FileList,
    required this.selectedFunction,

    required this.outputFormat,
    required this.outputEncodingFormat,
    required this.audioSampleRate,
    required this.audioChannelCount,
    required this.volumeMultiplier,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.resolution,
    required this.frameRate,
    required this.rotateAngle,
    required this.timePoint,
  });

  @override
  State<YoKi> createState() => _YoKiState();
}

class _YoKiState extends State<YoKi> {
  String resolutionH = "0";
  String resolutionW = "0";


  @override
  Widget build(BuildContext context) {

    void onTimeChanged(String startTime, String endTime, String duration) {
      setState(() {
        widget.startTime(startTime);
        widget.endTime(endTime);
        widget.duration(duration);
      });
    }

    void onTimePointChanged(String time) {
      setState(() {
        widget.timePoint(time);
      });
    }

    switch (widget.selectedFunction) {
      case 1:
        return Column(
          children: [
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
                    "Output Format",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  DropdownMenu(
                    enableFilter: true,
                    width: MediaQuery.of(context).size.width / 2,
                    onSelected: (sukiFormat) {
                      if(sukiFormat != null) {
                        setState(() {
                          widget.outputFormat(sukiFormat);
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<String>> [
                      DropdownMenuEntry(value: "mp4", label: ".mp4"),
                      DropdownMenuEntry(value: "mkv", label: ".mkv"),
                      DropdownMenuEntry(value: "avi", label: ".avi"),
                      DropdownMenuEntry(value: "mov", label: ".mov"),
                      DropdownMenuEntry(value: "webm", label: ".webm"),
                      DropdownMenuEntry(value: "ts", label: ".ts"),
                      DropdownMenuEntry(value: "m2ts", label: ".m2ts"),
                      DropdownMenuEntry(value: "3gp", label: ".3gp"),
                      DropdownMenuEntry(value: "ogv", label: ".ogv"),
                    ]
                  ),
                  SizedBox(height: 15,),
                ],
              )
            ),
          ],
        );

        case 2:
        return Column(
          children: [
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
                    "Output Encoding Format",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  DropdownMenu(
                    enableFilter: true,
                    width: MediaQuery.of(context).size.width / 2,
                    onSelected: (sukiFormat) {
                      if(sukiFormat != null) {
                        setState(() {
                          widget.outputEncodingFormat(sukiFormat);
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<String>> [
                      DropdownMenuEntry(value: "libx264", label: "H.264/AVC"),
                      DropdownMenuEntry(value: "libx265", label: "H.265/HEVC"),
                      DropdownMenuEntry(value: "libvpx-vp9", label: "VP9"),
                      DropdownMenuEntry(value: "libaom-av1", label: "AV1"),
                      DropdownMenuEntry(value: "mpeg2video", label: "MPEG-2"),
                      DropdownMenuEntry(value: "mpeg4", label: "MPEG-4 Part 2"),
                      DropdownMenuEntry(value: "vc1", label: "VC-1"),
                      DropdownMenuEntry(value: "prores", label: "ProRes"),
                      DropdownMenuEntry(value: "dnxhd", label: "DNxHD/DNxHR"),
                      DropdownMenuEntry(value: "mjpeg", label: "MJPEG"),
                    ]
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            SizedBox(height: 25,),
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
                    "Output Format",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  DropdownMenu(
                    enableFilter: true,
                    width: MediaQuery.of(context).size.width / 2,
                    onSelected: (sukiFormat) {
                      if(sukiFormat != null) {
                        setState(() {
                          widget.outputFormat(sukiFormat);
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<String>> [
                      DropdownMenuEntry(value: "mp4", label: ".mp4"),
                      DropdownMenuEntry(value: "mkv", label: ".mkv"),
                      DropdownMenuEntry(value: "avi", label: ".avi"),
                      DropdownMenuEntry(value: "mov", label: ".mov"),
                      DropdownMenuEntry(value: "webm", label: ".webm"),
                      DropdownMenuEntry(value: "ts", label: ".ts"),
                      DropdownMenuEntry(value: "m2ts", label: ".m2ts"),
                      DropdownMenuEntry(value: "3gp", label: ".3gp"),
                      DropdownMenuEntry(value: "ogv", label: ".ogv"),
                    ]
                  ),
                  SizedBox(height: 15,),
                ],
              )
            ),
          ],
        );
        
        case 3:
        return Column(
          children: [
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
                    "Start Time / End Time / Duration",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TimeInputComponent(onTimeChanged: onTimeChanged)
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        );

      case 4:
        return Column(
          children: [
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
                    "Resolution",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: "Height",
                          ),
                          onChanged: (value) {
                            setState(() {
                              resolutionH = value;
                              widget.resolution("${resolutionH}x$resolutionW");
                            });
                          },
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: "Width",
                          ),
                          onChanged: (value) {
                            setState(() {
                              resolutionW = value;
                              widget.resolution("${resolutionH}x$resolutionW");
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            )
          ],
        );

      case 5:
        return Column(
          children: [
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
                    "Frame Rate",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "FPS",
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.frameRate(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        );

      case 6:
        return Column(
          children: [
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
                    "Rotation Angle",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "Degree Measure, counterclockwise",
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.rotateAngle(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        );

      case 7:
        return Column(
          children: [
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
                    "Press the Button to Continue",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        );
      
      case 8:
        return Column(
          children: [
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
                    "Output Format",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  DropdownMenu(
                    enableFilter: true,
                    width: MediaQuery.of(context).size.width / 2,
                    onSelected: (sukiFormat) {
                      if(sukiFormat != null) {
                        setState(() {
                          widget.outputFormat(sukiFormat);
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<String>> [
                      DropdownMenuEntry(value: "mp3", label: ".mp3"),
                      DropdownMenuEntry(value: "aac", label: ".aac"),
                      DropdownMenuEntry(value: "m4a", label: ".m4a"),
                      DropdownMenuEntry(value: "wav", label: ".wav"),
                      DropdownMenuEntry(value: "aiff", label: ".aiff"),
                      DropdownMenuEntry(value: "aif", label: ".aif"),
                      DropdownMenuEntry(value: "flac", label: ".flac"),
                      DropdownMenuEntry(value: "ogg", label: ".ogg"),
                      DropdownMenuEntry(value: "opus", label: ".opus"),
                    ]
                  ),
                  SizedBox(height: 15,),
                ],
              )
            ),
          ],
        );
      
      case 9:
        return Column(
          children: [
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
                    "Time Point",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TimePointInputComponent(onTimePointChanged: onTimePointChanged)
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            SizedBox(height: 25,),
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
                    "Output Format",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  DropdownMenu(
                    enableFilter: true,
                    width: MediaQuery.of(context).size.width / 2,
                    onSelected: (sukiFormat) {
                      if(sukiFormat != null) {
                        setState(() {
                          widget.outputFormat(sukiFormat);
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<String>> [
                      DropdownMenuEntry(value: "png", label: ".png"),
                      DropdownMenuEntry(value: "jpg", label: ".jpg"),
                      DropdownMenuEntry(value: "jpeg", label: ".jpeg"),
                      DropdownMenuEntry(value: "bmp", label: ".bmp"),
                      DropdownMenuEntry(value: "tiff", label: ".tiff"),
                      DropdownMenuEntry(value: "tif", label: ".tif"),
                      DropdownMenuEntry(value: "webp", label: ".webp"),
                      DropdownMenuEntry(value: "dpx", label: ".dpx"),
                      DropdownMenuEntry(value: "pgm", label: ".pgm"),
                      DropdownMenuEntry(value: "ppm", label: ".ppm"),
                      DropdownMenuEntry(value: "pam", label: ".pam"),
                    ]
                  ),
                  SizedBox(height: 15,),
                ],
              )
            ),
          ],
        );

      case 11:
        return Column(
          children: [
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
                    "Output Format",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  DropdownMenu(
                    enableFilter: true,
                    width: MediaQuery.of(context).size.width / 2,
                    onSelected: (sukiFormat) {
                      if(sukiFormat != null) {
                        setState(() {
                          widget.outputFormat(sukiFormat);
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<String>> [
                      DropdownMenuEntry(value: "png", label: ".png"),
                      DropdownMenuEntry(value: "jpg", label: ".jpg"),
                      DropdownMenuEntry(value: "jpeg", label: ".jpeg"),
                      DropdownMenuEntry(value: "bmp", label: ".bmp"),
                      DropdownMenuEntry(value: "tiff", label: ".tiff"),
                      DropdownMenuEntry(value: "tif", label: ".tif"),
                      DropdownMenuEntry(value: "webp", label: ".webp"),
                      DropdownMenuEntry(value: "dpx", label: ".dpx"),
                      DropdownMenuEntry(value: "pgm", label: ".pgm"),
                      DropdownMenuEntry(value: "ppm", label: ".ppm"),
                      DropdownMenuEntry(value: "pam", label: ".pam"),
                    ]
                  ),
                  SizedBox(height: 15,),
                ],
              )
            ),
          ],
        );

      case 12:
        return Column(
          children: [
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
                    "Resolution",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: "Height",
                          ),
                          onChanged: (value) {
                            setState(() {
                              resolutionH = value;
                              widget.resolution("${resolutionH}x$resolutionW");
                            });
                          },
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: "Width",
                          ),
                          onChanged: (value) {
                            setState(() {
                              resolutionW = value;
                              widget.resolution("${resolutionH}x$resolutionW");
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            )
          ],
        );

      case 13:
        return Column(
          children: [
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
                    "Rotation Angle",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "Rotation Angle",
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.rotateAngle(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        );

      case 21:
        return Column(
          children: [
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
                    "Output Format",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  DropdownMenu(
                    enableFilter: true,
                    width: MediaQuery.of(context).size.width / 2,
                    onSelected: (sukiFormat) {
                      if(sukiFormat != null) {
                        setState(() {
                          widget.outputFormat(sukiFormat);
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<String>> [
                      DropdownMenuEntry(value: "mp3", label: ".mp3"),
                      DropdownMenuEntry(value: "aac", label: ".aac"),
                      DropdownMenuEntry(value: "m4a", label: ".m4a"),
                      DropdownMenuEntry(value: "wav", label: ".wav"),
                      DropdownMenuEntry(value: "aiff", label: ".aiff"),
                      DropdownMenuEntry(value: "aif", label: ".aif"),
                      DropdownMenuEntry(value: "flac", label: ".flac"),
                      DropdownMenuEntry(value: "ogg", label: ".ogg"),
                      DropdownMenuEntry(value: "opus", label: ".opus"),
                    ]
                  ),
                  SizedBox(height: 15,),
                ],
              )
            ),
          ],
        );

      case 22:
        return Column(
          children: [
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
                    "Output Encoding Format",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  DropdownMenu(
                    enableFilter: true,
                    width: MediaQuery.of(context).size.width / 2,
                    onSelected: (sukiFormat) {
                      if(sukiFormat != null) {
                        setState(() {
                          widget.outputEncodingFormat(sukiFormat);
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<String>> [
                      DropdownMenuEntry(value: "libmp3lame", label: "MP3"),
                      DropdownMenuEntry(value: "aac", label: "AAC"),
                      DropdownMenuEntry(value: "flac", label: "FLAC"),
                      DropdownMenuEntry(value: "libopus", label: "Opus"),
                      DropdownMenuEntry(value: "libvorbis", label: "Vorbits"),
                      DropdownMenuEntry(value: "pcm_s16le", label: "PCM"),
                      DropdownMenuEntry(value: "ac3", label: "AC3"),
                    ]
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            SizedBox(height: 25,),
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
                    "Output Format",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  DropdownMenu(
                    enableFilter: true,
                    width: MediaQuery.of(context).size.width / 2,
                    onSelected: (sukiFormat) {
                      if(sukiFormat != null) {
                        setState(() {
                          widget.outputFormat(sukiFormat);
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<String>> [
                      DropdownMenuEntry(value: "mp3", label: ".mp3"),
                      DropdownMenuEntry(value: "aac", label: ".aac"),
                      DropdownMenuEntry(value: "m4a", label: ".m4a"),
                      DropdownMenuEntry(value: "wav", label: ".wav"),
                      DropdownMenuEntry(value: "aiff", label: ".aiff"),
                      DropdownMenuEntry(value: "aif", label: ".aif"),
                      DropdownMenuEntry(value: "flac", label: ".flac"),
                      DropdownMenuEntry(value: "ogg", label: ".ogg"),
                      DropdownMenuEntry(value: "opus", label: ".opus"),
                    ]
                  ),
                  SizedBox(height: 15,),
                ],
              )
            ),
          ],
        );

      case 23:
        return Column(
          children: [
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
                    "Magnification",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "Magnification",
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.volumeMultiplier(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        );

      case 24:
        return Column(
          children: [
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
                    "Start Time / End Time / Duration",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TimeInputComponent(onTimeChanged: onTimeChanged)
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        );

      case 25:
        return Column(
          children: [
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
                    "Sample Rate",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "Sample Rate",
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.audioSampleRate(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        );

      case 26:
        return Column(
          children: [
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
                    "Channel Count",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "Channel Count",
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.audioChannelCount(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        );

      case 31:
        return Column(
          children: [
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
                    "Frame Rate",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "FrameRate",
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.frameRate(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        );

      case 32:
        return Column(
          children: [
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
                    "Frame Rate",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "FrameRate",
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.frameRate(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            SizedBox(height: 25,),
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
                    "Output Format",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  DropdownMenu(
                    enableFilter: true,
                    width: MediaQuery.of(context).size.width / 2,
                    onSelected: (sukiFormat) {
                      if(sukiFormat != null) {
                        setState(() {
                          widget.outputFormat(sukiFormat);
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<String>> [
                      DropdownMenuEntry(value: "png", label: ".png"),
                      DropdownMenuEntry(value: "jpg", label: ".jpg"),
                      DropdownMenuEntry(value: "jpeg", label: ".jpeg"),
                      DropdownMenuEntry(value: "bmp", label: ".bmp"),
                      DropdownMenuEntry(value: "tiff", label: ".tiff"),
                      DropdownMenuEntry(value: "tif", label: ".tif"),
                      DropdownMenuEntry(value: "webp", label: ".webp"),
                      DropdownMenuEntry(value: "dpx", label: ".dpx"),
                      DropdownMenuEntry(value: "pgm", label: ".pgm"),
                      DropdownMenuEntry(value: "ppm", label: ".ppm"),
                      DropdownMenuEntry(value: "pam", label: ".pam"),
                    ]
                  ),
                  SizedBox(height: 15,),
                ],
              )
            ),
          ],
        );
        
    }
    
    return Text("Fuck");
  }
}