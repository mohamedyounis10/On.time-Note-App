import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';
import 'state.dart';

class ToDoLogic extends Cubit<ToDoState> {
  ToDoLogic() : super(InitState()){
    _box = Hive.box<Task>('ToDO');
  }

  // Variables
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  bool isScheduleSelected = true;
  late Box<Task> _box;

  // Get data
  List<Task> get tasks => _box.values.toList();

  // Load tasks
  void loadTasks() async {
    emit(LoadingState());
    try {
      await Future.delayed(Duration(milliseconds: 500));
      if (_box.isEmpty) {
        emit(EmptyState());
      } else {
        emit(UpdateState(tasks));
      }
    } catch (e) {
      emit(ErrorState('Failed to load tasks: $e'));
    }
  }

  // Add task
  void addTask(Task task) {
    _box.put(task.id, task);
    emit(AddState(tasks));
  }

  // Update (toggle complete)
  void updateTask(int index, Task task) {
    _box.putAt(
      index,
      Task(
        task.id,
        task.text,
        !task.isTake,
        task.time,
      ),
    );
    emit(UpdateState(tasks));
  }

  // Remove
  void removeTask(int index) {
    _box.deleteAt(index);
    emit(RemoveState(tasks));
  }

  // Empty field
  void emptyField() {
    emit(EmptyState());
  }

  // Calendar
  void selectDay(DateTime day) {
    focusedDay = day;
    emit(SelectedDayState(focusedDay));
  }

  // Toggle schedule/note
  void toggleView(bool scheduleSelected) {
    isScheduleSelected = scheduleSelected;
    emit(ToggleViewState(isScheduleSelected));
  }

  // Check/Uncheck task
  void checkTask(int index, bool isChecked) {
    final task = _box.getAt(index);
    if (task != null) {
      _box.putAt(
        index,
        Task(task.id, task.text, isChecked, task.time),
      );
      emit(TaskCheckedState(tasks));
    }
  }
}
