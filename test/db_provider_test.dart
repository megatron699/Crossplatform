import 'package:flutter_test/flutter_test.dart';

import 'package:todo_list/database.dart';
import 'package:todo_list/task_model.dart';

void main() {
  group('CRUD operations', () {
    test("Task should be add", () {
      Task newTask = Task(taskDescription: "First task");
      var res = DbProvider.db.getTasks();
      print(res.toString());
      expect(res, "1");
    });
  });
}
