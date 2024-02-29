import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/status.dart';
import 'package:task_manager/tasks.dart';
import 'Component/component.dart';
import 'blockObserver/blocObserver.dart';
import 'cubit.dart';

void main() {
  runApp(const MyApp());
  Bloc.observer = MyBlocObserver();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primarySwatch : Colors.orange ,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: orangeColor,
    unselectedItemColor: Colors.grey,
        backgroundColor: gryColor,
    )
    ),
    home: TasksScreen(),
    );
  }
}

