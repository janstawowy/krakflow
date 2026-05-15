class TaskRepository {
  static final List<Task> tasks = [
    Task(title: "zrobic zadania z TAM", deadline: "31.03.2026", done: false, priority: "High"),
    Task(title: "Call z supportem mikromiekkich", deadline: "dzisiaj", done: true, priority: "Medium"),
    Task(title: "zrobic taski z jiry", deadline: "w tym tygodniu", done: false, priority: "Critical"),
    Task(title: "Zjesc obiad", deadline: "dzisiaj", done: true, priority: "Low"),
  ];

}

class Task {
  final String title;
  final String deadline;
  final bool done;
  final String priority;

  Task({required this.title,
    required this.deadline,
    required this.done,
    required this.priority});
}