import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/controller/tasks/tasks_bloc.dart';
import 'package:task_manager/core/constants/colors.dart';
import 'package:task_manager/view/widgets/auth/customtextfield.dart';

addtaskSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return const AddTaskSheet();
      });
}

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  GlobalKey<FormState> forkey = GlobalKey();
  TextEditingController task = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      padding: EdgeInsets.all(20.h),
      height: double.infinity,
      child: Form(
          key: forkey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 15.h,
            ),
            Text(
              ' Task',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            Container(
              margin: EdgeInsets.only(top: 25.h, bottom: 60.h),
              child: CustomTextFormField(
                mycontroller: task,
                valid: (value) {
                  if (value == null || value.isEmpty) {
                    return "Task Can't Be Empty";
                  }
                  return null;
                },
                labeltext: 'Task Title',
                obscureText: false,
              ),
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.all(3.h),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15)),
                  child: MaterialButton(
                      onPressed: () {
                        if (forkey.currentState!.validate()) {
                          BlocProvider.of<TasksBloc>(context)
                              .add(AddTask(task: task.text));
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Add Task',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700)))),
            ),
          ])),
    );
  }
}
