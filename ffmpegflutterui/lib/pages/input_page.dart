import 'package:ffmpegflutterui/pages/convert_page.dart';
import 'package:ffmpegflutterui/utils/file_list.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  List<String> fileList = ["test.mp4",];
  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result != null && result.files.isNotEmpty){
      setState(() {
        fileList += result.files.map((file) => file.name).toList();
      });
    }
    else {
      return;
    }
  }

  void removeFile(int index) {
    setState(() {
      fileList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          
          color: Colors.blueGrey[800],
          fontSize: 30,
        ),
        
        title: Text("Input"),
        backgroundColor: Colors.deepPurple[100],
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: pickFile,
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              print("傻逼东西,${fileList.join(', ')}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context) => ConvertPage(
                    fileList: fileList,
                  ),
                )
              );
            },
            child: Icon(Icons.save),
          )
        ],
      ),

      body: ListView.builder(
        itemCount: fileList.length,
        itemBuilder: (context, index){
          return FileList(
            fileName: fileList[index],
            deleteFunction: (context) => removeFile(index),
          );
        },
      ),

    );
  }
}