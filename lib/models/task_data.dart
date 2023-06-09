import 'package:flutter/foundation.dart';
import 'package:todoey_flutter/models/task.dart';
import 'dart:convert';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  void loadTasks() async {
    print('loading tasks');
    final prefs = await SharedPreferences.getInstance();
    String? encodedTasks = prefs.getString('tasks');
    encodedTasks ??= "[]";

    List<dynamic> parsedListJson = jsonDecode(encodedTasks);
    _tasks = List<Task>.from(parsedListJson
        .map<Task>((dynamic i) => Task(name: i["name"], isDone: i["isDone"])));
    notifyListeners();
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<dynamic> jsonTasks = List<dynamic>.from(
        _tasks.map<dynamic>((Task t) => {"name": t.name, "isDone": t.isDone}));
    prefs.setString('tasks', json.encode(jsonTasks));
  }

  UnmodifiableListView<Task> get tasks {
    print('getting tasks');
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask({required String taskName}) {
    _tasks.add(Task(name: taskName));
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggle();
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }
}
