import 'dart:io';

import 'package:ffmpegflutterui/pages/function_page.dart';
import 'package:ffmpegflutterui/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PlatformPage extends StatefulWidget {
  const PlatformPage({super.key});

  @override
  State<PlatformPage> createState() => _PlatformPageState();
}

class _PlatformPageState extends State<PlatformPage> {

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

    //ResultPage(),

    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.deepPurple[100],
      //   currentIndex: _selectedIndex,
      //   onTap: _navigateBottomBar,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.functions),
      //       label: "Choose Function",
      //     ),

      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: "Settings",
      //     ),

      //   ],
      // ),
    );
  }
}