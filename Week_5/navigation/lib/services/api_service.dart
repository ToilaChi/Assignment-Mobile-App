import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class ApiService {
  static const String baseUrl = 'https://amock.io/api/researchUTH';

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return (data['data'] as List).map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> fetchTaskDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/task/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Task.fromJson(data['data']);
    } else {
      throw Exception('Failed to load task detail');
    }
  }

  Future<bool> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/task/$id'));
    return response.statusCode == 200;
  }
}
