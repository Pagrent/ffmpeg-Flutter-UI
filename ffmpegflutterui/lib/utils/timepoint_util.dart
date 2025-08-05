import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimePointInputComponent extends StatefulWidget {
  final Function(String) onTimePointChanged;

  TimePointInputComponent({required this.onTimePointChanged});

  @override
  _TimePointInputComponentState createState() => _TimePointInputComponentState();
}

class _TimePointInputComponentState extends State<TimePointInputComponent> {
  TextEditingController timeController = TextEditingController();

  void _showInputDialog() async {
    final timeParts = await showDialog<List<int>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Time'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TimePartInput(label: 'Hours', index: 0)),
                SizedBox(width: 5),
                Expanded(child: TimePartInput(label: 'Minutes', index: 1)),
                SizedBox(width: 5),
                Expanded(child: TimePartInput(label: 'Seconds', index: 2)),
                SizedBox(width: 5),
                Expanded(child: TimePartInput(label: 'Milliseconds', index: 3, maxLength: 3)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                List<int> values = [];
                for (int i = 0; i < 4; i++) {
                  String value = TimePartInput.values[i].text;
                  values.add(value.isNotEmpty ? int.parse(value) : 0);
                }
                Navigator.of(context).pop(values);
              },
            ),
          ],
        );
      },
    );

    if (timeParts != null) {
      setState(() {
        timeController.text = formatTime(timeParts);
        widget.onTimePointChanged(formatTime(timeParts));
      });
    }
  }

  String formatTime(List<int> parts) {
    return '${parts[0]}:${parts[1].toString().padLeft(2, '0')}:${parts[2].toString().padLeft(2, '0')}.${parts[3].toString().padLeft(3, '0')}';
  }

  Duration? parseTime(String text) {
    RegExp regExp = RegExp(r'^(\d+):(\d{2}):(\d{2})\.(\d{3})$');
    Match? match = regExp.firstMatch(text);
    if (match != null) {
      int hours = int.parse(match.group(1)!);
      int minutes = int.parse(match.group(2)!);
      int seconds = int.parse(match.group(3)!);
      int milliseconds = int.parse(match.group(4)!) * 1;
      return Duration(hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: timeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Time',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: _showInputDialog,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TimePartInput extends StatelessWidget {
  static List<TextEditingController> values = List.generate(4, (_) => TextEditingController());

  final String label;
  final int index;
  final int maxLength;

  TimePartInput({required this.label, required this.index, this.maxLength = 2});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        TextField(
          controller: values[index],
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: maxLength,
        ),
      ],
    );
  }
}