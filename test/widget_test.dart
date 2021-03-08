// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/database.dart';

import 'package:todo_list/main.dart';
import 'package:todo_list/new_todo_dialog.dart';
import 'package:todo_list/task_model.dart';
import 'package:todo_list/todo_list_screen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    /* expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);*/

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    var newTodoDialog = find.widgetWithText(Widget, "New Task");
    //  find.
    // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    expect(newTodoDialog, findsOneWidget);
  });
  testWidgets('Add and remove a todo', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    //  var db = DbProvider.db.initDB();
    // Enter text and add the item...
    var task = new Task();
    task.taskDescription = "task";
    await tester.pump();
    await DbProvider.db.addTask(task);
    await tester.pump();
    // Swipe the item to dismiss it.
    await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));

    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Ensure that the item is no longer on screen.
    expect(find.text('task'), findsNothing);
  });
}
