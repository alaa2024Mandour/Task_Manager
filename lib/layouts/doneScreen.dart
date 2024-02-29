import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Component/component.dart';
import '../cubit.dart';
import '../status.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<TaskAppCubit,TaskAppStates>(
        listener: (BuildContext context, Object? state) { },
        builder: (BuildContext context, state) {
          var tasks = TaskAppCubit.get(context).doneTask;
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
                  child: screenTitle(title:"Done",subTitle: ''),
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