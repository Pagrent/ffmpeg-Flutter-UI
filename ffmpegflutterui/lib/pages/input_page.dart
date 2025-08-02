import 'dart:io';

import 'package:ffmpegflutterui/pages/convert_page.dart';
import 'package:ffmpegflutterui/utils/file_list.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class InputPage extends StatefulWidget {
  int selectedFunction;

  InputPage({
    required this.selectedFunction,
    super.key
  });

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String? workDir;

  Future<void> _getWorkingDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final targetDir = Directory('${dir.path}/FFmpegFlutterUI');
  
    if (!await targetDir.exists()) {                            //确保目录存在喵
      await targetDir.create(recursive: true);
    }
  
    workDir = targetDir.path; 
  }


  List<File> fileList = [];                                   //文件列表喵

  void pickFile() async {                                     //获取文件喵
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result != null && result.files.isNotEmpty){
      setState(() {
        fileList += result.paths.map((path) => File(path!)).toList();
      });
    }
    else {
      SnackBar(content: Text('Failed to pick file'));
    }
  }

  bool isCopying = false;
  double progress = 0;
  int filesCopied = 0;

  Future<void> _copyFilesToWorkingDir() async {                //复制到临时目录喵
    if (fileList.isEmpty || workDir == null) return;
    
    setState(() {
      isCopying = true;
      progress = 0;
      filesCopied = 0;
    });

    final totalFiles = fileList.length;
    
    for (int i = 0; i < totalFiles; i++) {
      final file = fileList[i];
      final fileName = file.path.split('/').last;
      final destPath = '$workDir/$fileName';
      
      try {
        await file.copy(destPath);
        debugPrint('已复制: $fileName');
      } catch (e) {
        debugPrint('复制失败 $fileName: $e');
      }
      
      setState(() {
        filesCopied = i + 1;
        progress = (i + 1) / totalFiles;
      });
    }
    
    setState(() => isCopying = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copy $filesCopied/$totalFiles files to working directory')
      ),
    );
  }

  void removeFile(int index) {
    setState(() {
      fileList.removeAt(index);
    });
  }

  void goToConvert(List<File> fuckList) {
    if(fileList.isNotEmpty){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConvertPage(
            fileList: fuckList,
            selectedFunction: widget.selectedFunction,
          ),
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Press the Add Button at Top Right Corner to Select File")
        )
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    
    _getWorkingDir();
    print("该死$workDir喵");
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          color: Colors.blueGrey[800],
          fontSize: 30,
        ),
        
        title: Text("Input"),
        backgroundColor: Colors.deepPurple[100],

        actions: [
          GestureDetector(
            onTap: pickFile,
            child: Container(
              height: 35,
              width: 60,
              child: Center(
                child: Text(
                  "Add a file",
                  style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 12
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              pickFile();
            },
            icon: Icon(Icons.add),
          ),
          SizedBox(width: 10,)
        ],
        
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _copyFilesToWorkingDir();
          goToConvert(
            fileList
          );
        },
        child: Icon(Icons.save),
      ),

      body: ListView.builder(
        itemCount: fileList.length,
        itemBuilder: (context, index){
          return FileList(
            fileName: fileList[index].path.split('/').last,
            deleteFunction: (context) => removeFile(index),
          );
        },
      ),

    );
  }
}