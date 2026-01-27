import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';

class DetailScreen extends StatelessWidget {
  final int taskId;
  final ApiService _apiService = ApiService();

  DetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              bool success = await _apiService.deleteTask(taskId);
              if (success && context.mounted) {
                Navigator.pop(
                  context,
                ); // Return and refresh list logic should be added
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<Task>(
        future: _apiService.fetchTaskDetail(taskId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching details"));
          }

          final task = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  task.description,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _infoChip("Category", task.category),
                    _infoChip("Status", task.status),
                    _infoChip("Priority", task.priority),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Subtasks",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ...task.subtasks.map(
                  (sub) => CheckboxListTile(
                    title: Text(sub.title),
                    value: sub.isCompleted,
                    onChanged: (val) {},
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
