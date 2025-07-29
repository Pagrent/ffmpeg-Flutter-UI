import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result != null){
      print(result.names);
    }
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

      floatingActionButton: FloatingActionButton(
        
        child: Icon(Icons.add),
        onPressed: pickFile,
      ),

    );
  }
}