import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/controller/tasks/tasks_bloc.dart';
import 'package:task_manager/core/constants/colors.dart';
import 'package:task_manager/data/model/tasks/taskmodel.dart';
import 'package:task_manager/view/widgets/auth/customtextfield.dart';

editsheet(BuildContext context, TaskModel taskModel) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          return EditTaskSheet(
            taskModel: taskModel,
            completed: taskModel.completed!,
          );
        });
      });
}

class EditTaskSheet extends StatefulWidget {
  final bool? completed;
  final TaskModel taskModel;
  const EditTaskSheet({
    super.key,
    this.completed,
    required this.taskModel,
  });

  @override
  State<EditTaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<EditTaskSheet> {
  GlobalKey<FormState> forkey = GlobalKey();
  bool? complete;
  changeswitch(bool val) {
    complete = val;
    setState(() {});
  }

  late TextEditingController task;
  @override
  void initState() {
    complete = widget.completed!;
    task = TextEditingController(text: widget.taskModel.todo!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TasksBloc tasksBloc = context.read<TasksBloc>();
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
            Text(
              ' Task',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h, bottom: 60.h),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                    activeColor: AppColors.primary,
                    value: complete!,
                    onChanged: (val) {
                      changeswitch(val);
                    }),
                Container(
                    padding: EdgeInsets.all(3.h),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(15)),
                    child: MaterialButton(
                        onPressed: () {
                          if (forkey.currentState!.validate()) {
                            // function
                            tasksBloc.add(EditTask(
                                task: task.text,
                                completed: complete!,
                                id: widget.taskModel.id!));
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Edit Task',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w700)))),
              ],
            )
          ])),
    );
  }
}
