import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeInputComponent extends StatefulWidget {
  final Function(String, String, String) onTimeChanged;

  TimeInputComponent({required this.onTimeChanged});

  @override
  _TimeInputComponentState createState() => _TimeInputComponentState();
}

class _TimeInputComponentState extends State<TimeInputComponent> {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  bool startTimeSelected = true;
  bool endTimeSelected = true;
  bool durationSelected = false;

  void _showInputDialog(String type) async {
    final timeParts = await showDialog<List<int>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter $type'),
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
        switch (type) {
          case 'Start Time':
            startTimeController.text = formatTime(timeParts);
            break;
          case 'End Time':
            endTimeController.text = formatTime(timeParts);
            break;
          case 'Duration':
            durationController.text = formatTime(timeParts);
            break;
        }
        calculateMissingField();
      });
    }
  }

  String formatTime(List<int> parts) {
    return '${parts[0]}:${parts[1].toString().padLeft(2, '0')}:${parts[2].toString().padLeft(2, '0')}.${parts[3].toString().padLeft(3, '0')}';
  }

  void calculateMissingField() {
    try {
      Duration? startTime = parseTime(startTimeController.text);
      Duration? endTime = parseTime(endTimeController.text);
      Duration? duration = parseTime(durationController.text);

      if (startTimeSelected && endTimeSelected && !durationSelected) {
        durationController.text = formatTime([(endTime! - startTime!).inHours, ((endTime - startTime).inMinutes % 60), ((endTime - startTime).inSeconds % 60), (((endTime - startTime).inMilliseconds % 1000) ~/ 1)]);
      } else if (startTimeSelected && durationSelected && !endTimeSelected) {
        endTimeController.text = formatTime([(startTime! + duration!).inHours, ((startTime + duration).inMinutes % 60), ((startTime + duration).inSeconds % 60), (((startTime + duration).inMilliseconds % 1000) ~/ 1)]);
      } else if (endTimeSelected && durationSelected && !startTimeSelected) {
        startTimeController.text = formatTime([(endTime! - duration!).inHours, ((endTime - duration).inMinutes % 60), ((endTime - duration).inSeconds % 60), (((endTime - duration).inMilliseconds % 1000) ~/ 1)]);
      }

      // Call the callback function with the updated times
      widget.onTimeChanged(
        startTimeController.text,
        endTimeController.text,
        durationController.text,
      );
    } catch (_) {}
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

  void toggleSelection(String type, bool selected) {
    setState(() {
      switch (type) {
        case 'Start Time':
          if (!selected || [endTimeSelected, durationSelected].where((v) => v).length <= 1) {
            startTimeSelected = selected;
          }
          break;
        case 'End Time':
          if (!selected || [startTimeSelected, durationSelected].where((v) => v).length <= 1) {
            endTimeSelected = selected;
          }
          break;
        case 'Duration':
          if (!selected || [startTimeSelected, endTimeSelected].where((v) => v).length <= 1) {
            durationSelected = selected;
          }
          break;
      }
      // Ensure exactly two checkboxes are selected
      if ([startTimeSelected, endTimeSelected, durationSelected].where((v) => v).length > 2) {
        switch (type) {
          case 'Start Time':
            startTimeSelected = false;
            break;
          case 'End Time':
            endTimeSelected = false;
            break;
          case 'Duration':
            durationSelected = false;
            break;
        }
      }
      calculateMissingField();
    });
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
                controller: startTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Start Time',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showInputDialog('Start Time'),
                  ),
                ),
              ),
            ),
            Checkbox(
              value: startTimeSelected,
              onChanged: (bool? value) {
                toggleSelection('Start Time', value ?? false);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: endTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'End Time',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showInputDialog('End Time'),
                  ),
                ),
              ),
            ),
            Checkbox(
              value: endTimeSelected,
              onChanged: (bool? value) {
                toggleSelection('End Time', value ?? false);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: durationController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Duration',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showInputDialog('Duration'),
                  ),
                ),
              ),
            ),
            Checkbox(
              value: durationSelected,
              onChanged: (bool? value) {
                toggleSelection('Duration', value ?? false);
              },
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