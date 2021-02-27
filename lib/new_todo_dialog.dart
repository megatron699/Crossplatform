import 'package:flutter/material.dart';
import 'package:todo_list/TaskModel.dart';

import 'Database.dart';


class NewTodoDialog extends StatelessWidget {
  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New task'),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Add'),
          onPressed: () {
            final task = new Task(title: controller.value.text, isDone: false);
            DBProvider.db.newTask(task);
            controller.clear();

            Navigator.of(context).pop(task);
          },
        ),
      ],
    );
  }
}
