import 'package:flutter/material.dart';

class ConfirmFile extends StatelessWidget {
  final String fileName;

  //double cardWidth = window.physicalSize.width / 2 - 25.0;

  ConfirmFile({
    super.key,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: MediaQuery.of(context).size.width / 2 - 25, top: 25,),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(
              Icons.file_present,
              color: Colors.blueGrey[800],
            ),
            Text(
              fileName,
              style: TextStyle(
                color: Colors.blueGrey[800],
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}