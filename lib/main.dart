import 'package:flutter/material.dart';
import 'task_repository.dart';
import 'task_api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'KrakFlow'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Task>> tasksFuture;

  @override
  void initState() {
    super.initState();
    tasksFuture = TaskApiService.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    //category['Subcategories'].where((subcategory) => subcategory.isFeatured)
    int completed_tasks = TaskRepository.tasks.where((task) => task.done).length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Task>>(
        future: tasksFuture,

        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Błąd: ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          final tasks = snapshot.data!;

          int completedTasks =
              tasks.where((task) => task.done).length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Masz dzisiaj ${tasks.length} zadania.\n"
                      "Wykonanych: $completedTasks",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Dzisiejsze zadania:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      title: tasks[index].title,
                      subtitle: "${tasks[index].deadline} | Priorytet: ${tasks[index].priority}",
                      icon: tasks[index].done ? Icons.check_circle : Icons.radio_button_unchecked,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Task? newTask = await
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => AddTaskScreen()),
            PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => AddTaskScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child,);
            }

            ),
          );
          if (newTask != null){
            setState(() {
              TaskRepository.tasks.add(newTask);
            });
          }
        },
        tooltip: 'Dodaj zadanie',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskScreen extends StatelessWidget{
  AddTaskScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nowe zadanie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Wpisz tytul zadania",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: deadlineController,
              decoration: InputDecoration(
                labelText: "Wpisz deadline zadania",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: priorityController,
              decoration: InputDecoration(
                labelText: "Podaj priorytet zadania",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(onPressed: () {
              final newTask = Task(
                title: titleController.text,
                deadline: deadlineController.text,
                priority: priorityController.text,
                done: false
              );
              Navigator.pop(context, newTask);
            },
                child: Text("Zapisz"))
          ],
        ),
      ),

    );
  }

}



class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const TaskCard({required this.title, required this.subtitle, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

// class Task {
//   final String title;
//   final String deadline;
//   final bool done;
//   final String priority;
//
//   Task({required this.title,
//         required this.deadline,
//         required this.done,
//         required this.priority});
// }