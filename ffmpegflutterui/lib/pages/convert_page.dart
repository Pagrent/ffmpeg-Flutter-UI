import 'dart:io';

import 'package:ffmpegflutterui/utils/confirm_file.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

    if(widget.fileList.isEmpty)
    {
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
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.redAccent[100],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Icon(
                  Icons.warning_amber_rounded,
                  size: 50,
                  color: Colors.red[800],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please Select File",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(


      appBar: AppBar(
        
        titleTextStyle: TextStyle(
          color: Colors.blueGrey[800],
          fontSize: 30,
        ),
        
        title: Text("Convert"),
        backgroundColor: Colors.deepPurple[100],
      ),


      body: ListView.builder(
        itemCount: widget.fileList.length,
        itemBuilder: (context, index){
          return ConfirmFile(
            fileName: widget.fileList[index].path.split('/').last,
          );
        },
      ),

      
    );
  }
}