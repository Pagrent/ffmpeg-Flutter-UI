import 'dart:io';

import 'package:ffmpegflutterui/pages/convert_page.dart';
import 'package:ffmpegflutterui/pages/function_page.dart';
import 'package:ffmpegflutterui/pages/input_page.dart';
import 'package:ffmpegflutterui/pages/result_page.dart';
import 'package:ffmpegflutterui/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PlatformPage extends StatefulWidget {
  const PlatformPage({super.key});

  @override
  State<PlatformPage> createState() => _PlatformPageState();
}

class _PlatformPageState extends State<PlatformPage> {

  Future<bool> _requestStoragePermission() async {           //权限喵
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true; // iOS/macOS 不需要显式请求
  }

  int _selectedIndex = 0;
  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index ;
    });
  }
  final List _pages = [
    FunctionPage(),

    //InputPage(),

    //ConvertPage(),

    ResultPage(),

    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple[100],
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.functions),
            label: "Choose Function",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.output),
            label: "Output File",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),

        ],
      ),
    );
  }
}