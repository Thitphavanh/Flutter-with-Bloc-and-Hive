import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc_and_hive/home/home.dart';
import 'package:flutter_with_bloc_and_hive/services/authentication.dart';
import 'package:flutter_with_bloc_and_hive/services/todo_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationService()),
        RepositoryProvider(create: (context) => TodoService()),
      ],
      child: MaterialApp(
        title: 'Todos',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(),
      ),
    );
  }
}
