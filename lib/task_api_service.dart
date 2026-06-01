import 'dart:convert';
import 'package:http/http.dart' as http;
import 'task_repository.dart';
import 'dart:math';
final random = Random();
final priorities = ["niski", "średni", "wysoki"];
final deadlines = ["teraz", "jutro", "za tydzien", "tak"];
final priority = priorities[random.nextInt(priorities.length)];
final deadline = deadlines[random.nextInt(deadlines.length)];

class TaskApiService {
  static const String baseUrl = "https://dummyjson.com/";
  static Future<List<Task>> fetchTasks() async {
    final response = await http.get(
        Uri.parse("$baseUrl/todos")
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List tasks = data["todos"];
      int id =0;
      return tasks.map((todo) {
        return Task(
          id: id++,
          title: todo["todo"],
          deadline: deadlines[random.nextInt(deadlines.length)],
          done: todo["completed"],
          priority: priorities[random.nextInt(priorities.length)],
        );
      }).toList();
    } else {
      throw Exception("Błąd pobierania danych");
    }
  }
}