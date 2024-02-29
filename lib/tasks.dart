import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/status.dart';
import 'Component/component.dart';
import 'cubit.dart';


//upload it is done
 class  TasksScreen extends StatelessWidget {
 final  titleController = TextEditingController();
 final dedLineController = TextEditingController();
 final timeController = TextEditingController();

 var scaffoldKey = GlobalKey<ScaffoldState>();
 var formKey = GlobalKey<FormState>();

  TasksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TaskAppCubit()..createDatabase(),
      child: BlocConsumer<TaskAppCubit , TaskAppStates>(
        listener: (BuildContext context, TaskAppStates state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, TaskAppStates state) {
          var cubit = TaskAppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShow){
                  if(formKey.currentState!.validate()){
                    cubit.insertToDatabase(
                      title: titleController.text,
                      date: dedLineController.text,
                      time: timeController.text,
                    );
                  }
                }
                else{
                  scaffoldKey.currentState?.showBottomSheet((context) => Container(
                    height: 350,
                    color: gryColor,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                          ),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: orangeColor,
                                  ),
                                ),),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                                child: Text(
                                  "Add Task",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                defaultTextFormField(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    hintText:"Task Title",
                                    labelText:"Task Title",
                                    preFix: Icons.text_fields_rounded,
                                    onTap: (){
                                      return null;
                                    }
                                ),
                                SizedBox(height: 15,),
                                defaultTextFormField(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    hintText:"Task Time",
                                    labelText:"Task Time",
                                    preFix: Icons.watch_later_outlined,
                                    onTap: (){
                                      showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now()).then(
                                              (value) {
                                            timeController.text=value!.format(context).toString();
                                            print(value.format(context));
                                          });
                                    }
                                ),
                                SizedBox(height: 15,),
                                defaultTextFormField(
                                    controller: dedLineController,
                                    type: TextInputType.text,
                                    hintText:"Deadline Date",
                                    labelText:"Deadline Date",
                                    preFix: Icons.date_range,
                                    onTap: (){
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2024-12-28')
                                      ).then((value) {
                                        dedLineController.text=DateFormat.yMMMd().format(value!);
                                        print(DateFormat.yMMMd().format(value));
                                      });
                                    }
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), ).closed.then((value) {
                    cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(
                cubit.fabIcon,
                color: orangeColor,
              ),
              backgroundColor: gryColor,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomNavBarItems,
              onTap: (index)=> cubit.changeScreensBottomNaveBar(index),
              currentIndex: cubit.currentIndex,
            ),
          );
        },
      ),
    );
  }
}
