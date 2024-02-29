import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/status.dart';

import 'layouts/archiveScreen.dart';
import 'layouts/doneScreen.dart';
import 'layouts/taskScreen.dart';

class TaskAppCubit extends Cubit<TaskAppStates>{
   TaskAppCubit(): super(InitialState());

   static TaskAppCubit get(context) => BlocProvider.of(context);

   //**************BottomNaveBare Actions with cubit******************
   List<Widget>screens=[
      const TaskScreen(),
      const DoneScreen(),
      const ArchiveScreen(),
   ];

   List<String>titles=[
      "todo",
      "done",
      "archive"
   ];

   List<String>subTitles=[
      "NewTasks",
      "DoneTasks",
      "ArchiveTasks"
   ];

   int currentIndex = 0 ;

   List<BottomNavigationBarItem> bottomNavBarItems = [
      const BottomNavigationBarItem(
          icon: Icon(
              Icons.menu,
          ),
         label: "Tasks"
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.done_all_outlined),
          label: "Done"
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.archive_outlined),
          label: "Archive"
      ),
   ];

   void changeScreensBottomNaveBar (index){
      currentIndex=index;
      emit(ChangeBottomNaveBareState());
   }

   //=========fabIcon Toggle============
   IconData fabIcon=Icons.edit;

   //=========Bottom Sheet Toggle============
   bool isBottomSheetShow=false;

   void changeBottomSheetState({
      required bool isShow,
      required IconData icon,
   }){
      isBottomSheetShow= isShow;
      fabIcon=icon;
      emit(ChangeBottomSheetState());
   }

   //================Database================
   late Database database;

   List<Map> newTask = [];
   List<Map> doneTask = [];
   List<Map> archiveTask = [];
//----------------create database-----------------

  void createDatabase ()  {
    openDatabase(
         'todo.db',
         version: 1,
         onCreate: (database,version){
               print("Database Created");
               database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
               .then((value){
                  print("Table Created");
               }).catchError((onError){
                  print("Error when create database is : ${onError.toString()}");
               });
         },
         onOpen: (database){
            print("Database opened");
        }
      ).then((value){
        database=value;
        emit(AppCreateDatabaseState());
     });
}

  Future insertToDatabase({
    required title,
    required date,
    required time,
  })async{
    return await database.transaction((txn)
    {
      txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")'
      ).then((value){
        print("$value Inserted Successfully");
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((erorr){
        print("error when enserting new record is ${erorr.toString()}");
      });
      return Future(() => null);
    });
  }

  void getDataFromDatabase(database) async {
    newTask = [];
    doneTask = [];
    archiveTask = [];
    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      value.forEach((element) {
        if(element['status']=='new'){
          newTask.add(element);
        }else if(element['status']=='done'){
          doneTask.add(element);
        } else archiveTask.add(element) ;
      });
      emit(AppGetDatabaseState());
    });
  }

  Future UpdateDatabase({
    required String status,
    required int id,
  })async{
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id=?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  Future deletDatabase({
    required int id,
  })async{
    database.rawUpdate(
      'DELETE FROM tasks WHERE id=?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}