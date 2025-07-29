import 'package:ffmpegflutterui/utils/confirm_file.dart';
import 'package:ffmpegflutterui/utils/file_list.dart';
import 'package:flutter/material.dart';

class ConvertPage extends StatefulWidget {
  final List<String> fileList;

  const ConvertPage({
    required this.fileList,
    super.key,
  });

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {


  @override
  void initState() {
  super.initState();
  print("你就赤石吧: ${widget.fileList.length}");
  print("赤这么多石: ${widget.fileList.join(', ')}");
}
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


      body: ListView.builder(
        itemCount: widget.fileList.length,
        itemBuilder: (context, index){
          return ConfirmFile(
            fileName: widget.fileList[index],
          );
        },
      ),

      
    );
  }
}