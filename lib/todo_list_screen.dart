import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

import 'package:todo_list/new_todo_dialog.dart';
import 'package:todo_list/database.dart';
import 'package:todo_list/task_model.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  File _file;

  _addTodo() async {
    final task = await showDialog<Task>(
      context: context,
      builder: (BuildContext context) {
        return NewTodoDialog();
      },
    );

    if (task != null) {
      task.isDone = false;
      setState(() {
        DbProvider.db.addTask(task);
      });
    }
  }

  void _getFromCamera(context) {
    _getFile(ImageSource.camera, context);
  }

  Future<void> _getFile(ImageSource source, BuildContext context) async {
    try {
      print(source);
      final File file = await ImagePicker.pickImage(source: source);
      setState(() {
        _file = File(file.path);
        _showBottomSheet(context);
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(file.path);
      await file.copy('${appDir.path.split("/")}/$fileName');
    } catch (e) {
      print(e);
    }
  }

  void _showBottomSheet(context) {
    if (_file != null) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Center(
                child: LimitedBox(
              child: Image.file(_file),
              maxHeight: 300,
            ));
          });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Task>>(
        future: DbProvider.db.getTasks(),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Task item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DbProvider.db.deleteTask(item.id);
                  },
                  child: ListTile(
                    title: Text(item.taskDescription),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        DbProvider.db.doneOrUndone(item);
                        setState(() {});
                      },
                      value: item.isDone,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addTodo(),
      ),
      persistentFooterButtons: <Widget>[
        ElevatedButton.icon(
            onPressed: () => _getFromCamera(context),
            icon: Icon(Icons.photo_camera),
            label: Text(AppLocalizations.of(context).takePhotoLabel))
      ],
    );
  }
}

