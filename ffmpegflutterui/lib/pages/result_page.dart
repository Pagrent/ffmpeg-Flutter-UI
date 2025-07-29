import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        titleTextStyle: TextStyle(
          color: Colors.blueGrey[800],
          fontSize: 30,
        ),
        
        title: Text("Output"),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}