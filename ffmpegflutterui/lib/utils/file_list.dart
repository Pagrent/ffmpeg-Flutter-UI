import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FileList extends StatelessWidget {
  final String fileName;
  Function(BuildContext)? deleteFunction;

  FileList({
    super.key,
    required this.fileName,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0,),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(20),
            )
          ],
        ),

        child: Container(
          width: MediaQuery.of(context).size.width - 50,
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
      ),
    );
  }
}