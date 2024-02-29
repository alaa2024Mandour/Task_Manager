import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Component/component.dart';
import '../cubit.dart';
import '../status.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<TaskAppCubit,TaskAppStates>(
        listener: (BuildContext context, Object? state) { },
        builder: (BuildContext context, state) {
          var tasks = TaskAppCubit.get(context).newTask;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 40,
                    right: 20,
                    left: 20,
                    bottom: 10,
                  ),
                  child: screenTitle(title: "Todo", subTitle: "NewTask"),
                ),
                taskConditionItemBuilder(tasks:tasks)
              ],
            ),
          );
        },
       ),
    );
  }
}
//
// BlocConsumer<AppCubit,AppStates>(taskAppCubit,
// listener: (BuildContext context, Object? state) { },
// builder: (BuildContext context, Object? state) {
// var tasks = AppCubit.get(context).NewTasks;
// return TaskConditionItmeBulder(tasks: tasks);
// },
