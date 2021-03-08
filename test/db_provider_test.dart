import 'package:flutter_test/flutter_test.dart';

import 'package:todo_list/database.dart';
import 'package:todo_list/task_model.dart';

void main() {
 // TestWidgetsFlutterBinding.ensureInitialized();
  group('CRUD operations', () {
    test("Task should be add", () async {

      Task newTask = Task(taskDescription: "First task");
      DbProvider.db.addTask(newTask);
      expect(await DbProvider.db.getTasks().then((value) => value.length), 1);
    });
  });
}
