import 'dart:ffi';

import 'package:ffmpegflutterui/pages/input_page.dart';
import 'package:ffmpegflutterui/utils/function_list_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FunctionList extends StatefulWidget {
  
  FunctionList({
    super.key,
    
  });

  @override
  State<FunctionList> createState() => _FunctionListState();
}

class _FunctionListState extends State<FunctionList> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Container(
          height: 120,
          width: MediaQuery.of(context).size.width / 2 + 35,
          decoration: BoxDecoration(
            color: Colors.deepPurple[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Category",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownMenu(
                enableFilter: true,
                width: MediaQuery.of(context).size.width / 2,
                onSelected: (Category) {
                  if (Category != null) {
                    setState(() {
                      selectedCategory = Category;
                    });
                  }
                },
                dropdownMenuEntries: <DropdownMenuEntry<int>>[
                  DropdownMenuEntry(value: 0, label: "All Functions"),
                  DropdownMenuEntry(value: 1, label: "Video Process"),
                  DropdownMenuEntry(value: 2, label: "Picture Process"),
                  DropdownMenuEntry(value: 3, label: "Audio Process"),
                  DropdownMenuEntry(value: 4, label: "Other Process")
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ShinoList(selectedCategory: selectedCategory)
      ]
    );
  }
}