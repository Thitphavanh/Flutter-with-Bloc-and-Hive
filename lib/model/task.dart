import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task {
  @HiveField(0)
  final String user;
  @HiveField(1)
  final String task;
  @HiveField(2)
  final String completed;

  Task(this.user, this.task, this.completed);
}
