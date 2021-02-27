import 'package:flutter/material.dart';
import 'package:todo_list/TaskModel.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewTodoDialog extends StatelessWidget {
  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).newTask),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).taskTextLabel,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(AppLocalizations.of(context).add),
          onPressed: () {
            final task = new Task(taskDescription: controller.value.text);

            controller.clear();

            Navigator.of(context).pop(task);

          },
        ),
      ],
    );
  }
}
