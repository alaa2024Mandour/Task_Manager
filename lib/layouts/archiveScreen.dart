import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Component/component.dart';
import '../cubit.dart';
import '../status.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<TaskAppCubit,TaskAppStates>(
        listener: (BuildContext context, Object? state) { },
        builder: (BuildContext context, state) {
          var tasks = TaskAppCubit.get(context).archiveTask;
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
                  child: screenTitle(title: "Archive", subTitle: ''),
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
