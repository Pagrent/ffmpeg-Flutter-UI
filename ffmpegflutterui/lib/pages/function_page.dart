import 'dart:math';

import 'package:ffmpegflutterui/pages/input_page.dart';
import 'package:ffmpegflutterui/utils/function_list.dart';
import 'package:flutter/material.dart';

class FunctionPage extends StatefulWidget {
  const FunctionPage({super.key});

  @override
  State<FunctionPage> createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {

  int selectedFunction = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          titleTextStyle: TextStyle(
            color: Colors.blueGrey[800],
            fontSize: 30,
          ),
        
          title: Text("Function"),
          backgroundColor: Colors.deepPurple[100],
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            FunctionList(
            ),

          ],
        ),
      ),
    );
    
  }
}