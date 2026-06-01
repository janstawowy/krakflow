class TaskRepository {
  static final List<Task> tasks = [
    Task(id:1, title: "zrobic zadania z TAM", deadline: "31.03.2026", done: false, priority: "High"),
    Task(id:2, title: "Call z supportem mikromiekkich", deadline: "dzisiaj", done: true, priority: "Medium"),
    Task(id:3, title: "zrobic taski z jiry", deadline: "w tym tygodniu", done: false, priority: "Critical"),
    Task(id:4, title: "Zjesc obiad", deadline: "dzisiaj", done: true, priority: "Low"),
  ];

}

class Task {
  final int id;
  final String title;
  final String deadline;
  final bool done;
  final String priority;

  Task({
    required this.id,
    required this.title,
    required this.deadline,
    required this.done,
    required this.priority});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "deadline": deadline,
      "priority": priority,
      "done": done,
    };
  }

  factory Task.fromMap(Map map) {
    return Task(
      id: map["id"],
      title: map["title"],
      deadline: map["deadline"],
      priority: map["priority"],
      done: map["done"],
    );
  }


}