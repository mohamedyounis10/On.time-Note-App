import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final bool isTake;

  @HiveField(3)
  final DateTime time;

  Task(this.id, this.text, this.isTake, this.time);
}
