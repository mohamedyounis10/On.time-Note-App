import '../models/task.dart';

abstract class ToDoState {}

class InitState extends ToDoState {}

class AddState extends ToDoState{
  final List<Task> tasks ;
  AddState(this.tasks);
}

class UpdateState extends ToDoState {
  final List<Task> tasks ;
  UpdateState(this.tasks);
}

class RemoveState extends ToDoState{
  final List<Task> tasks ;
  RemoveState(this.tasks);
}

class LoadingState extends ToDoState {}

class EmptyState extends ToDoState {}

class ErrorState extends ToDoState {
  final String message;
  ErrorState(this.message);
}

class SelectedDayState extends ToDoState {
  final DateTime selectedDay;
  SelectedDayState(this.selectedDay);
}

class ToggleViewState extends ToDoState {
  final bool isScheduleSelected;
  ToggleViewState(this.isScheduleSelected);
}

class TaskCheckedState extends ToDoState {
  final List<Task> tasks;
  TaskCheckedState(this.tasks);
}