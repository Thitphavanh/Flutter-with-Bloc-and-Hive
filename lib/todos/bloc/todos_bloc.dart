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
      emit(TodosLoadedState(todos));
    });
  }
}
