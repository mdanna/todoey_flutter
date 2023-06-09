import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool isDone;
  final Function checkCallback;
  final Function deleteCallback;

  TaskTile(
      {required this.taskName,
      required this.isDone,
      required this.checkCallback,
      required this.deleteCallback});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onLongPress: () {
          deleteCallback();
        },
        title: Text(
          taskName,
          style:
              TextStyle(decoration: isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isDone,
          onChanged: (value) {
            checkCallback(value);
          },
        ));
  }
}
