import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/models/task.dart';

import '../widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goToAddTaskPart();
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'To Do App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, value, child) => ListView.builder(
          itemCount: taskBox.values.toList().length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TaskWidget(
              task: taskBox.values.toList()[index],
            ),
          ),
        ),
      ),
    );
  }

  void _goToAddTaskPart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Add your task',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                ),
                controller: controller,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _addTask(Task(title: controller.text));
                      setState(() {
                        controller.text = '';
                      });

                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addTask(Task task) {
    setState(() {
      taskBox.add(task);
    });
  }
}
