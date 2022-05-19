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
        elevation: 0,
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
                children: [
                  ...state.tasks.map(
                    (e) => ListTile(
                      title: Text(e.task),
                      trailing: Checkbox(
                        value: e.completed,
                        onChanged: (val) {
                          BlocProvider.of<TodosBloc>(context).add(
                            ToggleTodoEvent(e.task),
                          );
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Create new task'),
                    trailing: Icon(Icons.create),
                    onTap: () async {
                      final result = await showDialog<String>(
                        context: context,
                        builder: (context) => Dialog(
                          child: CreateNewTask(),
                        ),
                      );
                      if (result != null) {
                        BlocProvider.of<TodosBloc>(context).add(
                          AddTodoEvent(result),
                        );
                      }
                    },
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('What task do you want to create?'),
        TextField(
          controller: _inputController,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_inputController.text);
          },
          child: Text('SAVE'),
        ),
      ],
    );
  }
}
