import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../cubit.dart';


//==============Reusable colors =================
Color? gryColor = Colors.grey[900];
Color? orangeColor = Colors.orange;
//================Task Item==================
Widget taskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (Direction) {
        TaskAppCubit.get(context).deletDatabase(id: model['id']);
      },
      background: Container(
        height: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.deepOrange,
              child: Text(
                "Delete Task",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              color: Colors.grey,
              child: Icon(Icons.archive,
              color: Colors.white,)
            ),
          ],
        ),
      ),
  secondaryBackground: Container(
      color: Colors.green,
      child: Icon(
        Icons.check_box_outline_blank_outlined,
        color: Colors.white,)
  ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: gryColor,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Dedline . ",
                          style: TextStyle(
                            color: Colors.deepOrange,
                          ),
                        ),
                        Text(
                          "${model['date']}",
                          style: const TextStyle(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "${model['title']} ",
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                    ), //titleTask
                  ],
                ),
              ),
            ),
            Expanded(
              child: Text(
                "${model['time']} ",
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );

//==============List View & condetioner builder ================
Widget taskConditionItemBuilder({
  required List<Map> tasks,
}) {
  return ConditionalBuilder(
    condition: tasks.isNotEmpty,
    builder: (context) => ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) =>
          taskItem(tasks[index], context),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 15,
      ),
      itemCount: tasks.length,
    ),
    fallback: (BuildContext context) {
      return const Center(
        child: Center(
          child: Image(
            image: AssetImage('assets/folder.png'),
            height: 350,
            width: 300,
          ),
        ),
      );
    },
  );
}

//============Task Form Fields================
Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onTap,
  required String hintText,
  required String labelText,
  required IconData preFix,
//=======for Password=========
  IconData? suFix,
  Function? suffixOnPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      //=======for Password=========
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onTap: () {
        onTap!();
      },
      validator: (value) {
        if (value == null || value.isEmpty) return 'Field is required.';
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          preFix,
          color: Colors.grey,
        ),
        suffix: suFix != null
            ? IconButton(
                onPressed: () {
                  suffixOnPressed!();
                },
                icon: Icon(suFix),
              )
            : null,
        //=======for Password=========
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        filled: true, //<-- SEE HERE
        fillColor: Colors.grey[800],
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
    );

//================= Screens ===================
Widget screenTitle({
  required String title,
  required String subTitle,
}) =>
    Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subTitle,
          style: TextStyle(
            color: orangeColor,
          ),
        ),
      ],
    );
