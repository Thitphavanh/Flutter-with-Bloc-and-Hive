part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class LoadTodosEvent extends TodosEvent {
  final String usename;

  LoadTodosEvent(this.usename);
  @override
  List<Object> get props => [usename];
}
