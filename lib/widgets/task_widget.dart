import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});

  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  var box = Hive.box<Task>('taskBox');

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteTask();
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
        ],
      ),
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            Text(
              widget.task.title,
              style: TextStyle(fontSize: 18),
            ),
            Checkbox(
              activeColor: Colors.black,
              value: widget.task.checked,
              onChanged: (checkValue) {
                setState(
                  () {
                    widget.task.checked = checkValue!;
                    widget.task.save();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask() {
    widget.task.delete();
  }
}
