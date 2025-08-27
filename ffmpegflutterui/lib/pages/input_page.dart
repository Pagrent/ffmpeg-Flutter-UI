import 'dart:io';

import 'package:ffmpegflutterui/pages/convert_page.dart';
import 'package:ffmpegflutterui/utils/file_list.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class InputPage extends StatefulWidget {
  int selectedFunction;
  int selectedCategory;

  InputPage({
    required this.selectedFunction,
    required this.selectedCategory,
    super.key
  });

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String? workDir;
  bool isLoading = true;

  Future<void> _getWorkingDir() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final targetDir = Directory('${dir.path}/FFmpegFlutterUI');
      final inputDir = Directory('${targetDir.path}/input');
      var outputDir = Directory('${targetDir.path}/output');
      if (Platform.isAndroid) {
        outputDir = Directory('/storage/emulated/0/Download/FFmpegFlutterUI');
      }

      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }
      if (!await inputDir.exists()) {
        await inputDir.create(recursive: true);
      }
      if (!await outputDir.exists()) {
        await outputDir.create(recursive: true);
      }

      setState(() {
        workDir = targetDir.path;
        isLoading = false;
      });
      //print("该死$workDir喵");
    } catch (e) {
      print('Error: $e');
      setState(() { isLoading = false; });
    }
  }


  List<File> fileList = [];                                   //文件列表喵

  void pickFile(int sukiCategory) async {                                     //获取文件喵

    // var status = await Permission.storage.status;
    // if (!status.isGranted) {
    //   status = await Permission.storage.request();
    // }
    // if (status.isGranted) {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     type: FileType.video,
    //     allowMultiple: true,
    //   );
    //   if (result != null && result.files.isNotEmpty) {
    //     setState(() {
    //       fileList += result.paths.map((path) => File(path!)).toList();
    //     });
    //   } else {
    //     SnackBar(content: Text('Failed to pick file'));
    //   }
    // } else {
    //   SnackBar(content: Text('Permission Denied'));
    // }

    void pickFile(int sukiCategory) async {
      Permission? perm;
      FileType fileType = FileType.any;

      if (sukiCategory == 1 || sukiCategory == 4) {
        perm = Permission.videos;
        fileType = FileType.video;
      } else if (sukiCategory == 2) {
        perm = Permission.photos;
        fileType = FileType.image;
      } else if (sukiCategory == 3) {
        perm = Permission.audio;
        fileType = FileType.audio;
      } else {
        perm = Permission.manageExternalStorage;
      }

      var status = await perm!.status;
      if (!status.isGranted) {
        status = await perm.request();
      }

      if (status.isGranted) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: fileType,
          allowMultiple: true,
        );
        if (result != null && result.files.isNotEmpty) {
          setState(() {
            fileList += result.paths.map((path) => File(path!)).toList();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to pick file')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Permission Denied')));
      }
    }
    
  }
/*
  void goToPickFile() async {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          selectedFormat: _getFormatFromDialogBox,
          selectedCategory: widget.selectedCategory,
          addFile: _getFileFromDialogBox,
        );
      }
    );
  }

  void _getFileFromDialogBox(List<File> newFile) {
    setState(() {
      fileList += newFile;
    });
  }

  String selectedFormat = "All";
  void _getFormatFromDialogBox(String sukiFormat) {
    setState(() {
      selectedFormat = sukiFormat;
    });
  }
  */

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
      final destPath = '$workDir/input/$fileName';
      
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
            selectedCategory: widget.selectedCategory,
            workDir: workDir,
          ),
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Press the Add Button at Top Right Corner to Select File.")
        )
      );
    }
  }

  

  @override
  void initState() {
    super.initState();
    _getWorkingDir();  // 这里调用，但由于async，需setState更新
  }


  @override
  Widget build(BuildContext context) {
    print("类别${widget.selectedCategory}");

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
            onTap: () {
              return pickFile(widget.selectedCategory);
            },
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
              return pickFile(widget.selectedCategory);
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

      body: isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
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