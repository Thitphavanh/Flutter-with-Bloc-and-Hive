import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_with_bloc_and_hive/model/task.dart';
import 'package:flutter_with_bloc_and_hive/services/todo_service.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final todos = _todoService.getTasks(event.usename);
      emit(TodosLoadedState(todos, event.usename));
    });
    on<AddTodoEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      _todoService.addTask(event.todoText, currentState.username);
      add(LoadTodosEvent(currentState.username));
    });

    on<ToggleTodoEvent>(
      (event, emit) async {
        final currentState = state as TodosLoadedState;
        await _todoService.updateTask(event.todoTask, currentState.username);
        add(LoadTodosEvent(currentState.username));
      },
    );
  }
}
