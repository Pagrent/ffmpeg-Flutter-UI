import 'package:ffmpegflutterui/pages/input_page.dart';
import 'package:ffmpegflutterui/utils/info_list.dart';
import 'package:flutter/material.dart';

class ShinoList extends StatefulWidget {
  final int? selectedCategory;

  ShinoList({
    super.key,
    required this.selectedCategory,
  });

  @override
  State<ShinoList> createState() => _ShinoListState();
}

class _ShinoListState extends State<ShinoList> {
  int selectedFunction = 0;

  @override
  Widget build(BuildContext context) {

    void goToInput() {
      print("傻逼$selectedFunction");
      if(selectedFunction != 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InputPage(
              selectedFunction: selectedFunction,
            )
          )
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please Select a Function")
          )
        );
      }
    }
    
    if(widget.selectedCategory == 1) {
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
                  "Video",
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
                  onSelected: (sukiFunction) {
                    if(sukiFunction != null) {
                      setState(() {
                        selectedFunction = sukiFunction;
                      });
                    }
                    else {
                      selectedFunction = 0;
                    }
                  },
                  dropdownMenuEntries: <DropdownMenuEntry<int>>[
                    DropdownMenuEntry(value: 0, label: "None"),

                    DropdownMenuEntry(value: 1, label: "Format Conversion"),
                    DropdownMenuEntry(value: 2, label: "Video Transcoding"),
                    DropdownMenuEntry(value: 3, label: "Trim Video"),
                    DropdownMenuEntry(value: 4, label: "Adjust Resolution"),
                    DropdownMenuEntry(value: 5, label: "Adjust Framerate"),
                    DropdownMenuEntry(value: 6, label: "Rotate Video"),
                    DropdownMenuEntry(value: 7, label: "Remove Audio Track"),
                    DropdownMenuEntry(value: 8, label: "Extract Audio Track"),
                    DropdownMenuEntry(value: 9, label: "Video Screenshot"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InfoList(
            selectedFunction: selectedFunction,
          ),
        ],
      );
    }
    if(widget.selectedCategory == 2) {
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
                  "Audio",
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
                  onSelected: (sukiFunction) {
                    if(sukiFunction != null) {
                      setState(() {
                        selectedFunction = sukiFunction;
                      });
                    }
                    else {
                      selectedFunction = 0;
                    }
                  },
                  dropdownMenuEntries: <DropdownMenuEntry<int>>[
                    DropdownMenuEntry(value: 0, label: "None"),

                    DropdownMenuEntry(value: 21, label: "Format Convertion"),
                    DropdownMenuEntry(value: 22, label: "Audio Transcoding"),
                    DropdownMenuEntry(value: 23, label: "Adjust Volume"),
                    DropdownMenuEntry(value: 24, label: "Trim Audio"),
                    DropdownMenuEntry(value: 25, label: "Convert Sample Rate"),
                    DropdownMenuEntry(value: 26, label: "Adjust Channel Count"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InfoList(
            selectedFunction: selectedFunction,
          ),
        ],
      );
    }
    if(widget.selectedCategory == 3) {
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
                  "Other",
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
                  onSelected: (sukiFunction) {
                    if(sukiFunction != null) {
                      setState(() {
                        selectedFunction = sukiFunction;
                      });
                    }
                    else {
                      selectedFunction = 0;
                    }
                  },
                  dropdownMenuEntries: <DropdownMenuEntry<int>>[
                    DropdownMenuEntry(value: 0, label: "None"),

                    DropdownMenuEntry(value: 31, label: "Video to GIF"),
                    DropdownMenuEntry(value: 32, label: "Extract Video Frames"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InfoList(
            selectedFunction: selectedFunction,
          ),
        ],
      );
    }

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
                "Function",
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
                onSelected: (sukiFunction) {
                  if(sukiFunction != null) {
                    setState(() {
                      selectedFunction = sukiFunction;
                    });
                  }
                  else {
                    selectedFunction = 0;
                  }
                },
                dropdownMenuEntries: <DropdownMenuEntry<int>>[
                  DropdownMenuEntry(value: 0, label: "None"),

                  DropdownMenuEntry(value: 1, label: "Format Conversion"),
                  DropdownMenuEntry(value: 2, label: "Video Transcoding"),
                  DropdownMenuEntry(value: 3, label: "Trim Video"),
                  DropdownMenuEntry(value: 4, label: "Adjust Resolution"),
                  DropdownMenuEntry(value: 5, label: "Adjust Framerate"),
                  DropdownMenuEntry(value: 6, label: "Rotate Video"),
                  DropdownMenuEntry(value: 7, label: "Remove Audio Track"),
                  DropdownMenuEntry(value: 8, label: "Extract Audio Track"),
                  DropdownMenuEntry(value: 9, label: "Video Screenshot"),
              
                  DropdownMenuEntry(value: 21, label: "Format Convertion"),
                  DropdownMenuEntry(value: 22, label: "Audio Transcoding"),
                  DropdownMenuEntry(value: 23, label: "Adjust Volume"),
                  DropdownMenuEntry(value: 24, label: "Trim Audio"),
                  DropdownMenuEntry(value: 25, label: "Convert Sample Rate"),
                  DropdownMenuEntry(value: 26, label: "Adjust Channel Count"),
              
                  DropdownMenuEntry(value: 31, label: "Video to GIF"),
                  DropdownMenuEntry(value: 32, label: "Extract Video Frames"),
                ],
              ),
            ],
          ),
        ),
        InfoList(
          selectedFunction: selectedFunction,
        ),
        FloatingActionButton(
          onPressed: goToInput,
          child: Icon(Icons.navigate_next),
        )
      ],
    );

    
  }
}