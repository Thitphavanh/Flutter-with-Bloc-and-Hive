// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_with_bloc_and_hive/services/todo_service.dart';
import 'package:flutter_with_bloc_and_hive/todos/bloc/todos_bloc.dart';

class TodosPage extends StatelessWidget {
  final String username;
  const TodosPage({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.red,
        backgroundColor: Colors.black,
        title: Text('Todo list'),
      ),
      body: BlocProvider(
        create: (context) =>
            TodosBloc(RepositoryProvider.of<TodoService>(context))
              ..add(LoadTodosEvent(username)),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(
                children: state.tasks
                    .map(
                      (e) => ListTile(
                        title: Text(e.task),
                        trailing: Checkbox(
                          value: e.completed,
                          onChanged: (val) {},
                        ),
                      ),
                    )
                    .toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
