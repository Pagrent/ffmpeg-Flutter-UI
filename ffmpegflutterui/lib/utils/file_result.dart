import 'package:flutter/material.dart';

class FileResult extends StatelessWidget {
  final String fileName;
  final bool isSuccess;

  const FileResult({
    super.key,
    required this.fileName,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    if(isSuccess == true) {
      return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25, top: 25,),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Text(
                fileName,
                style: TextStyle(
                  color: Colors.blueGrey[800],
                  fontSize: 18,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.download),
              )
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25, top: 25,),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Text(
              fileName,
              style: TextStyle(
                color: Colors.blueGrey[800],
                fontSize: 18,
              ),
            ),
            Spacer(),
            Icon(Icons.cancel)
          ],
        ),
      ),
    );
  }
}