import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc_and_hive/services/authentication.dart';
import 'package:flutter_with_bloc_and_hive/services/todo_service.dart';
import 'package:flutter_with_bloc_and_hive/todos/todos.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('Login to Todo App'),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(RegisterServicesEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TodoPage(username: state.username),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return Column(
                children: [
                  TextField(
                    controller: usernameField,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: passwordField,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  TextButton(
                    onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                      LoginEvent(usernameField.text, passwordField.text),
                    ),
                    child: Text('LOGIN'),
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
