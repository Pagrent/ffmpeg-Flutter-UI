import 'package:ffmpegflutterui/pages/convert_page.dart';
import 'package:ffmpegflutterui/pages/input_page.dart';
import 'package:ffmpegflutterui/pages/result_page.dart';
import 'package:ffmpegflutterui/pages/settings_page.dart';
import 'package:flutter/material.dart';

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
    InputPage(),

    ConvertPage(),

    ResultPage(),

    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: [

          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            label: "Select File",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            label: "Choose Convert Format"
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