part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class LoadTodosEvent extends TodosEvent {
  final String usename;

  LoadTodosEvent(this.usename);
  @override
  List<Object?> get props => [usename];
}

class AddTodoEvent extends TodosEvent {
  final String todoText;

  AddTodoEvent(this.todoText);

  @override
  // TODO: implement props
  List<Object?> get props => [todoText];
}

class ToggleTodoEvent extends TodosEvent {
  final String todoTask;

  ToggleTodoEvent(this.todoTask);

  @override
  // TODO: implement props
  List<Object?> get props => [todoTask];
}
