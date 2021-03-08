import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:todo_list/task_model.dart';


class DbProvider {
  DbProvider._();

  static final DbProvider db = DbProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TodoListDB.db");
    return await openDatabase(path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Task ("
              "id INTEGER PRIMARY KEY,"
              "task_description TEXT,"
              "is_done BIT"
              ")");
        });
  }

  addTask(Task newTask) async {
    final db = await database;
    var res = await db.insert("Task", newTask.toJson());
    return res;
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    var res = await db.query("Task");
    var list = res.isNotEmpty ? res.map((c) => Task.fromJson(c)).toList() : [];
    return list;
  }

  updateTask(Task newTask) async {
    final db = await database;
    var res = await db.update("Task", newTask.toJson(),
        where: "id = ?", whereArgs: [newTask.id]);
    return res;
  }
  deleteTask(int id) async {
    final db = await database;
    var res = db.delete("Task", where: "id = ?", whereArgs: [id]);
    return res;
  }

  doneOrUndone(Task task) async {
    final db = await database;
    Task done = Task(
        id: task.id,
        taskDescription: task.taskDescription,
        isDone: !task.isDone);
    var res = await db.update("Task", done.toJson(),
        where: "id = ?", whereArgs: [task.id]);
    return res;
  }
}



